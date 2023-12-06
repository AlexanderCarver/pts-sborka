ITEM.name = "Табак “Golden Virginia”"
ITEM.description = "Аккуратно упакованная темно-зеленая пачка табака с ярким логотипом."
ITEM.longdesc = "Один из наиболее старых брендов из Великобритании, где по прежнему имеет сильное влияние. Средней крепости жевательный табак."

ITEM.model = "models/lostsignalproject/items/consumable/hand_rolling_tobacco.mdl"

ITEM.sound = "stalkersound/inv_food_03.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 540

ITEM.quantity = 10
ITEM.restore = 60
--ITEM.toxin = 5
--ITEM.psyheal = 12

ITEM.weight = 0.010
ITEM.flatweight = 0.080

ITEM.exRender = false
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 180.02, 0),
	fov = 1.42
}



function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc2(tooltip, "Никотин", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/stamina.png"))
	ix.util.PropertyDesc2(tooltip, "Успокоительное", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/psiprot.png"))
end

ITEM.functions.use = {
	name = "Пожевать",
	icon = "icon16/stalker/swallow.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)

		ix.util.PlayerPerformBlackScreenAction(item.player, "Употребление...", 8, function(player) 
			player:AddBuff("buff_psyheal", 30, { amount = item.restore/60 }) --Делим на два.
			player:AddBuff("debuff_slowdamage", 10, { amount = item.restore/60 }) --Делим на два.
			player:GetCharacter():SatisfyAddictions("StrongSmokes")
			ix.chat.Send(player, "me", "достаёт пачку табака “Golden Virginia” и, отбирая себе горсточку в руку, закидывает под губу, поступательными движениями распределяя его по дёснам.")
		end)


		quantity = quantity - 1

		if (quantity >= 1) then
			item:SetData("quantity", quantity)
			return false
		end


		return true
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
	end
}