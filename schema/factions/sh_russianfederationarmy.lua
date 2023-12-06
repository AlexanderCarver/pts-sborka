FACTION.name = "Вооружённые силы Российской Федерации"
FACTION.description = "Войска РФ. Придумать описание позже."
FACTION.color = Color(128, 0, 0, 255)
FACTION.isDefault = true
FACTION.isGloballyRecognized = false
FACTION.models = {
    "models/leygun/rfarmy/soilder_rf_07.mdl"
}

function FACTION:OnTransfered(client)
	local character = client:GetCharacter()
	character:SetName(self:GetDefaultName())
	character:SetModel(self.models[1])
end

/*
function FACTION:OnCharacterCreated(client, character)
	local inventory = character:GetInventory()

	inventory:Add("ak47", 1)

end
*/

FACTION_RUSSIANARMY = FACTION.index