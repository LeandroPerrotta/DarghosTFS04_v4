function onThink(interval)
	autoBroadcast()
	return true
end

function autoBroadcast()

	local messages = {
		{text = "Adquira conta premium e ajude o Darghos a continuar crescendo! Voc� tamb�m poder� explorar novos lugares de ca�a, quests, ter sua propria house e muito mais! -> www.darghos.com.br/?ref=account.premium", chance = 10}
		{text = "Para evitar ser hackeado, nunca d� sua conta ou senha para ningu�m. E lembre-se, se alguem dizendo ser da staff pedir sua conta ou senha, denuncie! N�s nunca pediremos seus dados!", chance = 15}
		{text = "Curta nossa p�gina oficial no Facebook e participe de eventos e promo��es especiais! -> www.facebook.com/DarghosOT", chance = 30}
		{text = "E novo no server e tem duvida sobre alguma quest? Se um monstro dropa algum item? Quer um guia de cidades? Sobre isso e muito mais veja a se��o Darghop�dia no site! -> www.darghos.com.br", chance = 50}
		{text = "Tem alguma d�vida? Temos v�rias formas para os players se comunicarem com a staff, como help, mensagens no Facebook ou ent�o envie um e-mail para suporte@darghos.com!", chance = 100}
	}
	
	for k,v in pairs(messages) do
		local m = math.random(0, 100)
		if(m <= v.chance) then
			doBroadcastMessage(v.text, MESSAGE_TYPES["orange"])
			break
		end
	end	
end
