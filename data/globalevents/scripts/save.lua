local config = {
	broadcast = {120, 30},
	shallow = "no",
	delay = 120,
	events = 30
}

config.shallow = getBooleanFromString(config.shallow)

local function executeSave(seconds)
	if(isInArray(config.broadcast, seconds)) then
		local text = ""
		if(not config.shallow) then
			text = "Full s"
		else
			text = "S"
		end

		text = text .. "erver save within " .. seconds .. " seconds, please mind it may freeze!"
		doBroadcastMessage(text)
	end

	if(seconds > 0) then
		addEvent(executeSave, config.events * 1000, seconds - config.events)
	else
		 onSave()
	end
end

function onThink(interval)
	if(table.maxn(config.broadcast) == 0) then
		 onSave()
	else
		executeSave(config.delay)
	end

	return true
end

function onSave()
	doSaveServer(config.shallow)
	
	if(darghos_server_save_backup) then
		addEvent(os.execute, 500, "cd backups_hour && ./run.sh")
	end
end
