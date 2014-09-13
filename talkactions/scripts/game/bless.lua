local usePvPBless = false
local usePvEBless = true -- Inquisition

function onSay(cid, words, param)	
	local blesses = {
		{name="First", location="Quendor"},
		{name="Second", location="Aracura"},
		{name="Third", location="Aaragon"},
		{name="Fourth", location="Thaun"},
		{name="Fifth", location="Salazart"}
	}
	
	local totalBlesses = 0
	
	local message = "Confira se voc� possui todas as ben��es ou n�o:\n\n"
	
	for k,v in pairs(blesses) do
	
		if(getPlayerBless(cid, k)) then
			message = message .. v.name .. " (" .. v.location .. "): Completa\n"
			totalBlesses = totalBlesses + 1
		else
			message = message .. v.name .. " (" .. v.location .. "): n/a\n"
		end
	end
	
	message = message .. "\n\nChance de perder itens:"
	
	if(totalBlesses > 0) then
		if (totalBlesses == #blesses) then
			message = message .. "\nVoc� est� completamente aben�oado pelos Deuses, os itens em seu invent�rio e mochila est�o completamente seguros!"
		else
			local lossBackpack = 100
			local lossInventory = 100
		
			if(totalBlesses == 1) then
				lossBackpack = 70
				lossInventory = 7
			elseif(totalBlesses == 2) then
				lossBackpack = 45
				lossInventory = 4.5		
			elseif(totalBlesses == 3) then
				lossBackpack = 25
				lossInventory = 2.5	
			elseif(totalBlesses == 4) then
				lossBackpack = 10
				lossInventory = 1			
			end
			
			message = message .. "\nVoc� est� aben�oado por " .. totalBlesses .. " deuses. Com isso a chance de quando voc� morrer perder sua mochila � de " .. lossBackpack .. "% e " .. lossInventory .. "% para outros itens em seu invent�rio."
		end
	else
		message = message .. "\nCuidado! Voc� n�o possui nenhuma ben��o! A chance de voc� perder itens ou sua mochila s�o muito altas!"
	end
	
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, message)
	message = ""
	
	if(usePvPBless) then
		message = message .. "\n\nBen��o do PvP (twist of fate):"
		
		if(getPlayerPVPBlessing(cid)) then	
			message = message .. "\nVoc� possui ben��o do PvP. Assim suas ben��es normais est�o protegidas quando voc� morre e 40% ou mais dos danos recebidos no ultimo minutos foram causados por outros jogadores (n�o montros)!"
		else
			message = message .. "\nVoc� n�o possui a ben��o do PvP! Voc� ir� perder suas ben��es regulares caso morra mesmo para outros jogadores! Compre-a em qualquer NPC dentro dos templos!"
		end
	end	

	if(usePvEBless) then
		message = message .. "\n\nBen��o do Inquisitor:"
		
		if(getPlayerPVEBlessing(cid)) then	
			message = message .. "\nVoc� prestou enorme ajuda ao Constantino no combate as for�as dem�niacas. Suas ben��es estar�o sempre protegido caso voc� morra para monstros!"
		else
			message = message .. "\nVoc� pode obter esta ben��o ao concluir a Quest da Inquisi��o. Procure o NPC Constantino em Thorn para maiores informa��es."
		end
	end		
	
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, message)
	return true	
end