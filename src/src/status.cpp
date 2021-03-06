/**
 * The Forgotten Server - a free and open-source MMORPG server emulator
 * Copyright (C) 2015  Mark Samman <mark.samman@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

#include "otpch.h"

#include "status.h"
#include "configmanager.h"
#include "game.h"
#include "connection.h"
#include "networkmessage.h"
#include "outputmessage.h"
#include "tools.h"
#include "dispatcher.h"

extern ConfigManager g_config;
extern Game g_game;

std::map<uint32_t, int64_t> Status::ipConnectMap;
const uint64_t Status::start = OTSYS_TIME();

enum RequestedInfo_t : uint16_t {
    REQUEST_BASIC_SERVER_INFO = 1 << 0,
    REQUEST_OWNER_SERVER_INFO = 1 << 1,
    REQUEST_MISC_SERVER_INFO = 1 << 2,
    REQUEST_PLAYERS_INFO = 1 << 3,
    REQUEST_MAP_INFO = 1 << 4,
    REQUEST_EXT_PLAYERS_INFO = 1 << 5,
    REQUEST_PLAYER_STATUS_INFO = 1 << 6,
    REQUEST_SERVER_SOFTWARE_INFO = 1 << 7,
};

void Status::onRecvFirstMessage(NetworkMessage& msg)
{
    uint32_t ip = getIP();

    if (ip != 0x0100007F) {
        std::string ipStr = convertIPAddress(ip);
        //std::clog << "[Status Protocol] New connection from " << ipStr << "." << std::endl;
        if (ipStr != g_config.getString(ConfigManager::IP)) {
            std::map<uint32_t, int64_t>::const_iterator it = ipConnectMap.find(ip);
            if (it != ipConnectMap.end() && (OTSYS_TIME() < (it->second + g_config.getNumber(ConfigManager::STATUSQUERY_TIMEOUT)))) {
                getConnection()->close();
                return;
            }
        }
    }

    ipConnectMap[ip] = OTSYS_TIME();

    switch (msg.getByte()) {
        //XML info protocol
        case 0xFF: {
            if (msg.getString(4) == "info") {
                g_dispatcher.addTask(createTask(std::bind(&Status::sendStatusString, this)));
                return;
            }
            break;
        }

        //Another ServerInfo protocol
        case 0x01: {
            uint16_t requestedInfo = msg.get<uint16_t>(); // only a Byte is necessary, though we could add new info here
            std::string characterName;
            if (requestedInfo & REQUEST_PLAYER_STATUS_INFO) {
                characterName = msg.getString();
            }
            //std::clog << "[Status Protocol] Parsing ServerInfo data (." << requestedInfo << ")." << std::endl;
            g_dispatcher.addTask(createTask(std::bind(&Status::sendInfo, this, requestedInfo, characterName)));
            return;
        }

        default:
            break;
    }
    getConnection()->close();
}

void Status::sendStatusString()
{
    OutputMessage_ptr output = OutputMessagePool::getInstance()->getOutputMessage(this, false);
    if (!output) {
        getConnection()->close();
        return;
    }

    setRawMessages(true);

    pugi::xml_document doc;

    pugi::xml_node decl = doc.prepend_child(pugi::node_declaration);
    decl.append_attribute("version") = "1.0";

    pugi::xml_node tsqp = doc.append_child("tsqp");
    tsqp.append_attribute("version") = "1.0";

    pugi::xml_node serverinfo = tsqp.append_child("serverinfo");
    uint64_t uptime = (OTSYS_TIME() - Status::start) / 1000;
    serverinfo.append_attribute("uptime") = std::to_string(uptime).c_str();
    serverinfo.append_attribute("ip") = g_config.getString(ConfigManager::IP).c_str();
    serverinfo.append_attribute("servername") = g_config.getString(ConfigManager::SERVER_NAME).c_str();
    serverinfo.append_attribute("port") = std::to_string(g_config.getNumber(ConfigManager::LOGIN_PORT)).c_str();
    serverinfo.append_attribute("location") = g_config.getString(ConfigManager::LOCATION).c_str();
    serverinfo.append_attribute("url") = g_config.getString(ConfigManager::URL).c_str();
    serverinfo.append_attribute("server") = SOFTWARE_NAME;
    serverinfo.append_attribute("version") = SOFTWARE_VERSION;
    serverinfo.append_attribute("client") = SOFTWARE_PROTOCOL;

    pugi::xml_node owner = tsqp.append_child("owner");
    owner.append_attribute("name") = g_config.getString(ConfigManager::OWNER_NAME).c_str();
    owner.append_attribute("email") = g_config.getString(ConfigManager::OWNER_EMAIL).c_str();

    pugi::xml_node players = tsqp.append_child("players");
    players.append_attribute("online") = std::to_string(g_game.getPlayersOnline()).c_str();
    players.append_attribute("max") = std::to_string(g_config.getNumber(ConfigManager::MAX_PLAYERS)).c_str();
    players.append_attribute("peak") = std::to_string(g_game.getPlayersRecord()).c_str();

    pugi::xml_node monsters = tsqp.append_child("monsters");
    monsters.append_attribute("total") = std::to_string(g_game.getMonstersOnline()).c_str();

    pugi::xml_node npcs = tsqp.append_child("npcs");
    npcs.append_attribute("total") = std::to_string(g_game.getNpcsOnline()).c_str();

    pugi::xml_node rates = tsqp.append_child("rates");
    rates.append_attribute("experience") = std::to_string(g_config.getNumber(ConfigManager::RATE_EXPERIENCE)).c_str();
    rates.append_attribute("skill") = std::to_string(g_config.getNumber(ConfigManager::RATE_SKILL)).c_str();
    rates.append_attribute("loot") = std::to_string(g_config.getNumber(ConfigManager::RATE_LOOT)).c_str();
    rates.append_attribute("magic") = std::to_string(g_config.getNumber(ConfigManager::RATE_MAGIC)).c_str();
    rates.append_attribute("spawn") = std::to_string(g_config.getNumber(ConfigManager::RATE_SPAWN)).c_str();

    pugi::xml_node map = tsqp.append_child("map");
    map.append_attribute("name") = g_config.getString(ConfigManager::MAP_NAME).c_str();
    map.append_attribute("author") = g_config.getString(ConfigManager::MAP_AUTHOR).c_str();

    uint32_t mapWidth, mapHeight;
    g_game.getMapDimensions(mapWidth, mapHeight);
    map.append_attribute("width") = std::to_string(mapWidth).c_str();
    map.append_attribute("height") = std::to_string(mapHeight).c_str();

    pugi::xml_node motd = tsqp.append_child("motd");
    motd.text() = g_config.getString(ConfigManager::MOTD).c_str();

    std::ostringstream ss;
    doc.save(ss, "", pugi::format_raw);

    std::string data = ss.str();
    output->addBytes(data.c_str(), data.size());
    OutputMessagePool::getInstance()->send(output);
    getConnection()->close();
}

void Status::sendInfo(uint16_t requestedInfo, const std::string& characterName)
{
    OutputMessage_ptr output = OutputMessagePool::getInstance()->getOutputMessage(this, false);
    if (!output) {
        getConnection()->close();
        return;
    }

    if (requestedInfo & REQUEST_BASIC_SERVER_INFO) {
        output->addByte(0x10);
        output->addString(g_config.getString(ConfigManager::SERVER_NAME));
        output->addString(g_config.getString(ConfigManager::IP));
        output->addString(std::to_string(g_config.getNumber(ConfigManager::LOGIN_PORT)));
    }

    if (requestedInfo & REQUEST_OWNER_SERVER_INFO) {
        output->addByte(0x11);
        output->addString(g_config.getString(ConfigManager::OWNER_NAME));
        output->addString(g_config.getString(ConfigManager::OWNER_EMAIL));
    }

    if (requestedInfo & REQUEST_MISC_SERVER_INFO) {
        output->addByte(0x12);
        output->addString(g_config.getString(ConfigManager::MOTD));
        output->addString(g_config.getString(ConfigManager::LOCATION));
        output->addString(g_config.getString(ConfigManager::URL));
        output->add<uint64_t>((OTSYS_TIME() - Status::start) / 1000);
    }

    if (requestedInfo & REQUEST_PLAYERS_INFO) {
        output->addByte(0x20);
        output->add<uint32_t>(g_game.getPlayersOnline());
        output->add<uint32_t>(g_config.getNumber(ConfigManager::MAX_PLAYERS));
        output->add<uint32_t>(g_game.getPlayersRecord());
    }

    if (requestedInfo & REQUEST_MAP_INFO) {
        output->addByte(0x30);
        output->addString(g_config.getString(ConfigManager::MAP_NAME));
        output->addString(g_config.getString(ConfigManager::MAP_AUTHOR));
        uint32_t mapWidth, mapHeight;
        g_game.getMapDimensions(mapWidth, mapHeight);
        output->add<uint16_t>(mapWidth);
        output->add<uint16_t>(mapHeight);
    }

    if (requestedInfo & REQUEST_EXT_PLAYERS_INFO) {
        output->addByte(0x21); // players info - online players list

        std::list<std::pair<std::string, uint32_t> > players;
        for(AutoList<Player>::iterator it = Player::autoList.begin(); it != Player::autoList.end(); ++it)
        {
            if(!it->second->isRemoved() && !it->second->isGhost())
                players.push_back(std::make_pair(it->second->getName(), it->second->getLevel()));
        }

        output->add<uint32_t>(players.size());
        for (const auto& it : players) {
            output->addString(it.first);
            output->add<uint32_t>(it.second);
        }
    }

    if (requestedInfo & REQUEST_PLAYER_STATUS_INFO) {
        output->addByte(0x22); // players info - online status info of a player
        if (g_game.getPlayerByName(characterName) != nullptr) {
            output->addByte(0x01);
        } else {
            output->addByte(0x00);
        }
    }

    if (requestedInfo & REQUEST_SERVER_SOFTWARE_INFO) {
        output->addByte(0x23); // server software info
        output->addString(SOFTWARE_NAME);
        output->addString(SOFTWARE_VERSION);
        output->addString(SOFTWARE_PROTOCOL);
    }
    OutputMessagePool::getInstance()->send(output);
    getConnection()->close();
}

void Status::updateDb(){
    Database* db = Database::getInstance();
    DBQuery query;
    query << "TRUNCATE `server_status`";
    if(!db->query(query.str()))
        return;

    query.str("");

    uint64_t uptime = (OTSYS_TIME() - Status::start) / 1000;

    query << "INSERT INTO `server_status` (`uptime`, `ip`, `servername`, `port`, `location`, `url`, `server`, `version`, `protocol`, `owner_name`, `owner_email`, `players_online`, `players_max`, `players_peak`, `monsters`, `npcs`, `map_name`, `map_author`, `map_width`, `map_height`) VALUES (";
    query << uptime;
    query << ", '" << g_config.getString(ConfigManager::IP).c_str() << "'";
    query << ", '" << g_config.getString(ConfigManager::SERVER_NAME).c_str() << "'";
    query << ", " << g_config.getNumber(ConfigManager::LOGIN_PORT);
    query << ", '" << g_config.getString(ConfigManager::LOCATION).c_str() << "'";
    query << ", '" << g_config.getString(ConfigManager::URL).c_str() << "'";
    query << ", '" << SOFTWARE_NAME << "'";
    query << ", '" << SOFTWARE_VERSION << "'";
    query << ", '" << SOFTWARE_PROTOCOL << "'";
    query << ", '" << g_config.getString(ConfigManager::OWNER_NAME).c_str() << "'";
    query << ", '" << g_config.getString(ConfigManager::OWNER_EMAIL).c_str() << "'";
    query << ", " << g_game.getPlayersOnline();
    query << ", " << g_config.getNumber(ConfigManager::MAX_PLAYERS);
    query << ", " << g_game.getPlayersRecord();
    query << ", " << g_game.getMonstersOnline();
    query << ", " << g_game.getNpcsOnline();
    query << ", '" << g_config.getString(ConfigManager::MAP_NAME).c_str() << "'";
    query << ", '" << g_config.getString(ConfigManager::MAP_AUTHOR).c_str() << "'";

    uint32_t mapWidth, mapHeight;
    g_game.getMapDimensions(mapWidth, mapHeight);

    query << ", " << mapWidth;
    query << ", " << mapHeight;

    query << ")";

    db->query(query.str());
}
