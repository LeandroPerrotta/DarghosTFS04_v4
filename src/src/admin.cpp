////////////////////////////////////////////////////////////////////////
// OpenTibia - an opensource roleplaying game
////////////////////////////////////////////////////////////////////////
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
////////////////////////////////////////////////////////////////////////
#include "otpch.h"
#ifdef __OTADMIN__
#include <iostream>

#include "admin.h"
#include "rsa.h"
#include "tools.h"

#include "configmanager.h"
#include "game.h"

#include "connection.h"
#include "outputmessage.h"
#include "networkmessage.h"

#include "house.h"
#include "town.h"
#include "iologindata.h"

extern ConfigManager g_config;
extern Game g_game;

#ifdef __ENABLE_SERVER_DIAGNOSTIC__
uint32_t ProtocolAdmin::protocolAdminCount = 0;
#endif

void ProtocolAdmin::onRecvFirstMessage(NetworkMessage& msg)
{
	m_state = NO_CONNECTED;
	if(g_config.getString(ConfigManager::ADMIN_PASSWORD).empty())
	{
		addLogLine(LOGTYPE_EVENT, "connection attempt on disabled protocol");
		getConnection()->close();
		return;
	}

	if(!Admin::getInstance()->allow(getIP()))
	{
		addLogLine(LOGTYPE_EVENT, "ip not allowed");
		getConnection()->close();
		return;
	}

	if(!Admin::getInstance()->addConnection())
	{
		addLogLine(LOGTYPE_EVENT, "cannot add new connection");
		getConnection()->close();
		return;
	}

	addLogLine(LOGTYPE_EVENT, "sending HELLO");
	if(OutputMessage_ptr output = OutputMessagePool::getInstance()->getOutputMessage(this, false))
	{
        TRACK_MESSAGE(output);
        output->addByte(AP_MSG_HELLO);
        output->add<uint32_t>(1); //version
        output->addString("OTADMIN");

        output->add<uint16_t>(Admin::getInstance()->getPolicy()); //security policy
        output->add<uint32_t>(Admin::getInstance()->getOptions()); //protocol options(encryption, ...)
		OutputMessagePool::getInstance()->send(output);
	}

	m_lastCommand = time(NULL);
	m_state = ENCRYPTION_NO_SET;
}

void ProtocolAdmin::parsePacket(NetworkMessage& msg)
{
	if(g_game.getGameState() == GAMESTATE_SHUTDOWN)
	{
		getConnection()->close();
		return;
	}

	uint8_t recvbyte = msg.get<char>();
	OutputMessage_ptr output = OutputMessagePool::getInstance()->getOutputMessage(this, false);
	if(!output)
		return;

	TRACK_MESSAGE(output);
	switch(m_state)
	{
		case ENCRYPTION_NO_SET:
		{
			if(Admin::getInstance()->isEncypted())
			{
				if((time(NULL) - m_startTime) > 30000)
				{
					getConnection()->close();
					addLogLine(LOGTYPE_EVENT, "encryption timeout");
					return;
				}

				if(recvbyte != AP_MSG_ENCRYPTION && recvbyte != AP_MSG_KEY_EXCHANGE)
				{
                    output->addByte(AP_MSG_ERROR);
                    output->addString("encryption needed");
					OutputMessagePool::getInstance()->send(output);

					getConnection()->close();
					addLogLine(LOGTYPE_EVENT, "wrong command while ENCRYPTION_NO_SET");
					return;
				}
			}
			else
				m_state = NO_LOGGED_IN;

			break;
		}

		case NO_LOGGED_IN:
		{
			if(g_config.getBool(ConfigManager::ADMIN_REQUIRE_LOGIN))
			{
				if((time(NULL) - m_startTime) > 30000)
				{
					//login timeout
					getConnection()->close();
					addLogLine(LOGTYPE_EVENT, "login timeout");
					return;
				}

				if(m_loginTries > 3)
				{
                    output->addByte(AP_MSG_ERROR);
                    output->addString("too many login tries");
					OutputMessagePool::getInstance()->send(output);

					getConnection()->close();
					addLogLine(LOGTYPE_EVENT, "too many login tries");
					return;
				}

				if(recvbyte != AP_MSG_LOGIN)
				{
                    output->addByte(AP_MSG_ERROR);
                    output->addString("you are not logged in");
					OutputMessagePool::getInstance()->send(output);

					getConnection()->close();
					addLogLine(LOGTYPE_EVENT, "wrong command while NO_LOGGED_IN");
					return;
				}
			}
			else
				m_state = LOGGED_IN;

			break;
		}

		case LOGGED_IN:
			break;

		default:
		{
			getConnection()->close();
			addLogLine(LOGTYPE_EVENT, "no valid connection state!!!");
			return;
		}
	}

	m_lastCommand = time(NULL);
	switch(recvbyte)
	{
		case AP_MSG_LOGIN:
		{
			if(m_state == NO_LOGGED_IN && g_config.getBool(ConfigManager::ADMIN_REQUIRE_LOGIN))
			{
				std::string pass = msg.getString(), word = g_config.getString(ConfigManager::ADMIN_PASSWORD);
				_encrypt(word, false);
				if(pass == word)
				{
					m_state = LOGGED_IN;
                    output->addByte(AP_MSG_LOGIN_OK);
					addLogLine(LOGTYPE_EVENT, "login ok");
				}
				else
				{
					m_loginTries++;
                    output->addByte(AP_MSG_LOGIN_FAILED);
                    output->addString("wrong password");
					addLogLine(LOGTYPE_EVENT, "login failed.("+ pass + ")");
				}
			}
			else
			{
                output->addByte(AP_MSG_LOGIN_FAILED);
                output->addString("cannot login");
				addLogLine(LOGTYPE_EVENT, "wrong state at login");
			}

			break;
		}

		case AP_MSG_ENCRYPTION:
		{
			if(m_state == ENCRYPTION_NO_SET && Admin::getInstance()->isEncypted())
			{
				uint8_t keyType = msg.get<char>();
				switch(keyType)
				{
					case ENCRYPTION_RSA1024XTEA:
					{
						RSA* rsa = Admin::getInstance()->getRSAKey(ENCRYPTION_RSA1024XTEA);
						if(!rsa)
						{
                            output->addByte(AP_MSG_ENCRYPTION_FAILED);
							addLogLine(LOGTYPE_EVENT, "no valid server key type");
							break;
						}

						if(RSA_decrypt(rsa, msg))
						{
							m_state = NO_LOGGED_IN;
							uint32_t k[4]= {msg.get<uint32_t>(), msg.get<uint32_t>(), msg.get<uint32_t>(), msg.get<uint32_t>()};

							//use for in/out the new key we have
							enableXTEAEncryption();
							setXTEAKey(k);

                            output->addByte(AP_MSG_ENCRYPTION_OK);
							addLogLine(LOGTYPE_EVENT, "encryption ok");
						}
						else
						{
                            output->addByte(AP_MSG_ENCRYPTION_FAILED);
                            output->addString("wrong encrypted packet");
							addLogLine(LOGTYPE_EVENT, "wrong encrypted packet");
						}

						break;
					}

					default:
					{
                        output->addByte(AP_MSG_ENCRYPTION_FAILED);
                        output->addString("no valid key type");

						addLogLine(LOGTYPE_EVENT, "no valid client key type");
						break;
					}
				}
			}
			else
			{
                output->addByte(AP_MSG_ENCRYPTION_FAILED);
                output->addString("cannot set encryption");
				addLogLine(LOGTYPE_EVENT, "cannot set encryption");
			}

			break;
		}

		case AP_MSG_KEY_EXCHANGE:
		{
			if(m_state == ENCRYPTION_NO_SET && Admin::getInstance()->isEncypted())
			{
				uint8_t keyType = msg.get<char>();
				switch(keyType)
				{
					case ENCRYPTION_RSA1024XTEA:
					{
						RSA* rsa = Admin::getInstance()->getRSAKey(ENCRYPTION_RSA1024XTEA);
						if(!rsa)
						{
                            output->addByte(AP_MSG_KEY_EXCHANGE_FAILED);
							addLogLine(LOGTYPE_EVENT, "no valid server key type");
							break;
						}

                        output->addByte(AP_MSG_KEY_EXCHANGE_OK);
                        output->addByte(ENCRYPTION_RSA1024XTEA);

						char RSAPublicKey[128];
						rsa->getPublicKey(RSAPublicKey);

						output->put<char>s(RSAPublicKey, 128);
						break;
					}

					default:
					{
                        output->addByte(AP_MSG_KEY_EXCHANGE_FAILED);
						addLogLine(LOGTYPE_EVENT, "no valid client key type");
						break;
					}
				}
			}
			else
			{
                output->addByte(AP_MSG_KEY_EXCHANGE_FAILED);
                output->addString("cannot get public key");
				addLogLine(LOGTYPE_EVENT, "cannot get public key");
			}

			break;
		}

		case AP_MSG_COMMAND:
		{
			if(m_state != LOGGED_IN)
			{
				addLogLine(LOGTYPE_EVENT, "recvbyte == AP_MSG_COMMAND && m_state != LOGGED_IN !!!");
				break;
			}

			uint8_t command = msg.get<char>();
			switch(command)
			{
				case CMD_SAVE_SERVER:
				case CMD_SHALLOW_SAVE_SERVER:
				{
					addLogLine(LOGTYPE_EVENT, "saving server");
                    g_dispatcher.addTask(createTask(std::bind(
						&Game::saveGameState, &g_game, (command == CMD_SHALLOW_SAVE_SERVER))));

                    output->addByte(AP_MSG_COMMAND_OK);
					break;
				}

				case CMD_CLOSE_SERVER:
				{
					addLogLine(LOGTYPE_EVENT, "closing server");
                    g_dispatcher.addTask(createTask(std::bind(
						&Game::setGameState, &g_game, GAMESTATE_CLOSED)));

                    output->addByte(AP_MSG_COMMAND_OK);
					break;
				}

				case CMD_OPEN_SERVER:
				{
					addLogLine(LOGTYPE_EVENT, "opening server");
					g_game.setGameState(GAMESTATE_NORMAL);

                    output->addByte(AP_MSG_COMMAND_OK);
					break;
				}

				case CMD_SHUTDOWN_SERVER:
				{
					addLogLine(LOGTYPE_EVENT, "shutting down server");
                    g_dispatcher.addTask(createTask(std::bind(
						&Game::setGameState, &g_game, GAMESTATE_SHUTDOWN)));

                    output->addByte(AP_MSG_COMMAND_OK);
					break;
				}

				case CMD_PAY_HOUSES:
				{
                    g_dispatcher.addTask(createTask(std::bind(
						&ProtocolAdmin::adminCommandPayHouses, this)));
					break;
				}

				case CMD_RELOAD_SCRIPTS:
				{
					const int8_t reload = msg.get<char>();
                    g_dispatcher.addTask(createTask(std::bind(
						&ProtocolAdmin::adminCommandReload, this, reload)));
					break;
				}

				// why do we run these below on dispatcher thread anyway?
				case CMD_KICK:
				{
					const std::string param = msg.getString();
                    g_dispatcher.addTask(createTask(std::bind(
						&ProtocolAdmin::adminCommandKickPlayer, this, param)));
					break;
				}

				case CMD_SEND_MAIL:
				{
					const std::string xmlData = msg.getString();
                    g_dispatcher.addTask(createTask(std::bind(
						&ProtocolAdmin::adminCommandSendMail, this, xmlData)));
					break;
				}

				case CMD_BROADCAST:
				{
					const std::string param = msg.getString();
					addLogLine(LOGTYPE_EVENT, "broadcasting: " + param);
                    g_dispatcher.addTask(createTask(std::bind(
						&Game::broadcastMessage, &g_game, param, MSG_STATUS_WARNING)));

                    output->addByte(AP_MSG_COMMAND_OK);
					break;
				}

				default:
				{
                    output->addByte(AP_MSG_COMMAND_FAILED);
                    output->addString("not known server command");
					addLogLine(LOGTYPE_EVENT, "not known server command");
				}
			}
			break;
		}

		case AP_MSG_PING:
            output->addByte(AP_MSG_PING_OK);
			break;

		case AP_MSG_KEEP_ALIVE:
			break;

		default:
		{
            output->addByte(AP_MSG_ERROR);
            output->addString("not known command byte");

			addLogLine(LOGTYPE_EVENT, "not known command byte");
			break;
		}
	}

	if(output->size() > 0)
		OutputMessagePool::getInstance()->send(output);
}

void ProtocolAdmin::deleteProtocolTask()
{
	addLogLine(LOGTYPE_EVENT, "end connection");
	Admin::getInstance()->removeConnection();
	Protocol::deleteProtocolTask();
}

void ProtocolAdmin::adminCommandPayHouses()
{
	OutputMessage_ptr output = OutputMessagePool::getInstance()->getOutputMessage(this, false);
	if(!output)
		return;

	Houses::getInstance()->payHouses();
	addLogLine(LOGTYPE_EVENT, "pay houses ok");

	TRACK_MESSAGE(output);
    output->addByte(AP_MSG_COMMAND_OK);
	OutputMessagePool::getInstance()->send(output);
}

void ProtocolAdmin::adminCommandReload(int8_t reload)
{
	OutputMessage_ptr output = OutputMessagePool::getInstance()->getOutputMessage(this, false);
	if(!output)
		return;

	g_game.reloadInfo((ReloadInfo_t)reload);
	addLogLine(LOGTYPE_EVENT, "reload ok");

	TRACK_MESSAGE(output);
    output->addByte(AP_MSG_COMMAND_OK);
	OutputMessagePool::getInstance()->send(output);
}

void ProtocolAdmin::adminCommandKickPlayer(const std::string& param)
{
	OutputMessage_ptr output = OutputMessagePool::getInstance()->getOutputMessage(this, false);
	if(!output)
		return;

	TRACK_MESSAGE(output);
	Player* player = NULL;
	if(g_game.getPlayerByNameWildcard(param, player) == RET_NOERROR)
	{
        g_scheduler.addEvent(createSchedulerTask(SCHEDULER_MINTICKS, std::bind(&Game::kickPlayer, &g_game, player->getID(), false)));
		addLogLine(LOGTYPE_EVENT, "kicking player " + player->getName());
        output->addByte(AP_MSG_COMMAND_OK);
	}
	else
	{
		addLogLine(LOGTYPE_EVENT, "failed setting kick for player " + param);
        output->addByte(AP_MSG_COMMAND_FAILED);
        output->addString("player is not online");
	}

	OutputMessagePool::getInstance()->send(output);
}

void ProtocolAdmin::adminCommandSendMail(const std::string& xmlData)
{
	OutputMessage_ptr output = OutputMessagePool::getInstance()->getOutputMessage(this, false);
	if(!output)
		return;

	std::string name;
	uint32_t depotId;

	TRACK_MESSAGE(output);
	if(Item* mailItem = Admin::createMail(xmlData, name, depotId))
	{
		if(IOLoginData::getInstance()->playerMail(NULL, name, depotId, mailItem))
		{
			addLogLine(LOGTYPE_EVENT, "sent mailbox to " + name);
            output->addByte(AP_MSG_COMMAND_OK);
		}
		else
		{
			addLogLine(LOGTYPE_EVENT, "failed sending mailbox to " + name);
            output->addByte(AP_MSG_COMMAND_FAILED);
            output->addString("could not send the box");
		}
	}
	else
	{
		addLogLine(LOGTYPE_EVENT, "failed parsing mailbox");
        output->addByte(AP_MSG_COMMAND_FAILED);
        output->addString("could not parse the box");
	}

	OutputMessagePool::getInstance()->send(output);
}

Admin::Admin(): m_currrentConnections(0), m_encrypted(false),
	m_key_RSA1024XTEA(NULL)
{
	std::string strValue = g_config.getString(ConfigManager::ADMIN_ENCRYPTION);
	if(!strValue.empty())
	{
		toLowerCaseString(strValue);
		if(strValue == "rsa1024xtea")
		{
			m_key_RSA1024XTEA = new RSA();
			if(!m_key_RSA1024XTEA->initialize(getFilePath(FILE_TYPE_CONFIG,
				g_config.getString(ConfigManager::ADMIN_ENCRYPTION_DATA))))
			{
				std::clog << "[Warning - Admin::Admin] Unable to set RSA1024XTEA key!" << std::endl;
				delete m_key_RSA1024XTEA;
				m_key_RSA1024XTEA = NULL;
			}
			else
				m_encrypted = true;
		}
	}
}

Admin::~Admin()
{
	delete m_key_RSA1024XTEA;
	m_key_RSA1024XTEA = NULL;
}

bool Admin::addConnection()
{
	if(m_currrentConnections >= g_config.getNumber(ConfigManager::ADMIN_CONNECTIONS_LIMIT))
		return false;

	m_currrentConnections++;
	return true;
}

void Admin::removeConnection()
{
	if(m_currrentConnections > 0)
		m_currrentConnections--;
}

uint16_t Admin::getPolicy() const
{
	uint16_t policy = 0;
	if(g_config.getBool(ConfigManager::ADMIN_REQUIRE_LOGIN))
		policy |= REQUIRE_LOGIN;

	if(m_encrypted)
		policy |= REQUIRE_ENCRYPTION;

	return policy;
}

uint32_t Admin::getOptions() const
{
	uint32_t ret = 0;
	if(m_encrypted)
	{
		if(m_key_RSA1024XTEA)
			ret |= ENCRYPTION_RSA1024XTEA;
	}

	return ret;
}

Item* Admin::createMail(const std::string xmlData, std::string& name, uint32_t& depotId)
{
	xmlDocPtr doc = xmlParseMemory(xmlData.c_str(), xmlData.length());
	if(!doc)
		return NULL;

	xmlNodePtr root = xmlDocGetRootElement(doc);
	if(xmlStrcmp(root->name,(const xmlChar*)"mail"))
		return NULL;

	int32_t intValue;
	std::string strValue;

	int32_t itemId = ITEM_PARCEL;
	if(readXMLString(root, "to", strValue))
		name = strValue;

	if(readXMLString(root, "town", strValue))
	{
		Town* town = Towns::getInstance()->getTown(strValue);
		if(!town)
			return false;

		depotId = town->getID();
	}
	else if(!IOLoginData::getInstance()->getDefaultTownByName(name, depotId)) //use the players default town
		return false;

	if(readXMLInteger(root, "id", intValue))
		itemId = intValue;

	Item* mailItem = Item::CreateItem(itemId);
	mailItem->setParent(VirtualCylinder::virtualCylinder);
	if(Container* mailContainer = mailItem->getContainer())
	{
		xmlNodePtr node = root->children;
		while(node)
		{
			if(node->type != XML_ELEMENT_NODE)
			{
				node = node->next;
				continue;
			}

			if(!Item::loadItem(node, mailContainer))
			{
				delete mailContainer;
				return NULL;
			}

			node = node->next;
		}
	}

	return mailItem;
}

bool Admin::allow(uint32_t ip) const
{
	if(!g_config.getBool(ConfigManager::ADMIN_LOCALHOST_ONLY))
		return !ConnectionManager::getInstance()->isDisabled(ip, 0xFE);

	if(ip == 0x0100007F) //127.0.0.1
		return true;

	if(g_config.getBool(ConfigManager::ADMIN_LOGS))
		LOG_MESSAGE(LOGTYPE_EVENT, "forbidden connection try", "ADMIN " + convertIPAddress(ip));

	return false;
}

RSA* Admin::getRSAKey(uint8_t type)
{
	switch(type)
	{
		case ENCRYPTION_RSA1024XTEA:
			return m_key_RSA1024XTEA;

		default:
			break;
	}

	return NULL;
}

void ProtocolAdmin::addLogLine(LogType_t type, std::string message)
{
	if(g_config.getBool(ConfigManager::ADMIN_LOGS))
		LOG_MESSAGE(type, message, "ADMIN " + convertIPAddress(getIP()))
}
#endif
