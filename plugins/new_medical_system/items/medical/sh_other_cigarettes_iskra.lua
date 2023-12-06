ITEM.name = "Сигареты “Искра”"
ITEM.description = "Пачка сигарет. Всё не так уж плохо на сегодняшний день."
ITEM.longdesc = "Табачная сигарета 4-го класса. Имеет сладкий травянистый запах. При курении остается сладкое послевкусие и сухость во рту."
ITEM.model = "models/lostsignalproject/items/consumable/cigarettes_sparkle.mdl"

ITEM.sound = "stalkersound/inv_smoke.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 320

ITEM.quantity = 20
ITEM.restore = 60
--ITEM.toxin = 5
--ITEM.psyheal = 12

ITEM.weight = 0.001
ITEM.flatweight = 0.008

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
	name = "Покурить",
	icon = "icon16/stalker/smoke.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)

		ix.util.PlayerPerformBlackScreenAction(item.player, "Употребление...", 8, function(player) 
			player:AddBuff("buff_psyheal", 20, { amount = item.restore/60 }) --Делим на два.
			player:AddBuff("debuff_slowdamage", 10, { amount = item.restore/60 }) --Делим на два.
			player:GetCharacter():SatisfyAddictions("LightSmokes")
			ix.chat.Send(player, "me", "достает пачку сигарет Искра и берет одну из них в рот, после чего закуривает, наполняя воздух горьким табачным дымом. Обладают вкусом смолы и заметной сладкой гаречью.")
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