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

#define __OTPCH__
#if defined WINDOWS
#include <boost/asio/detail/socket_types.hpp>
#include <winerror.h>
#endif

#include <libxml/xmlmemory.h>
#include <libxml/parser.h>

#include <functional>
#include <iostream>
#include <fstream>

//libxml
#include <libxml/xmlmemory.h>
#include <libxml/parser.h>
#include <libxml/threads.h>

//boost
#include <boost/config.hpp>
#include <boost/function.hpp>
#include <boost/bind.hpp>
#include <boost/regex.hpp>
#include <boost/tokenizer.hpp>

#include <mutex>
#include <thread>
#include <unordered_map>
#include <list>
#include <forward_list>
#include <vector>
#include <deque>

//otserv
#include "thing.h"

#include "ext/pugixml.hpp"
