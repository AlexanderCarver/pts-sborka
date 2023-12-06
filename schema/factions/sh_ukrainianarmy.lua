FACTION.name = "Збройні сили України"
FACTION.description = "Продумать описание, Украина."
FACTION.color = Color(0, 0, 205, 255)
FACTION.isDefault = true
FACTION.isGloballyRecognized = false
FACTION.models = {
    "models/leygun/ua_army/soilder_ua_07.mdl"
}

function FACTION:OnTransfered(client)
	local character = client:GetCharacter()
	character:SetName(self:GetDefaultName())
	character:SetModel(self.models[1])
end

/*
function FACTION:OnCharacterCreated(client, character)
	local inventory = character:GetInventory()

	--inventory:Add("ak47", 1)

end
*/

FACTION_UKRAINIANARMY = FACTION.index