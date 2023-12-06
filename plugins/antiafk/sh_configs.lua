
ix.config.Add("afkTime", 600, "Время, которое требуется для получения статуса АФК.", function(oldValue, newValue)
	if (SERVER) then
		for _, v in ipairs(player.GetAll()) do
			if (v:GetCharacter()) then
				timer.Adjust("ixAntiAFK"..v:SteamID64(), newValue)
			end
		end
	end
end, {
	data = {min = 60, max = 3600},
	category = "antiafk"
})
