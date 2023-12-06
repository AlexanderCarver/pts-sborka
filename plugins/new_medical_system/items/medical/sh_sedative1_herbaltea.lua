ITEM.name = "Травяной сбор из лёгких трав"
ITEM.description = "Металлическая кружка с напитком."
ITEM.longdesc = "Приятный на вкус травяной чай. Оказывает успокаивающее действие, помогает справиться со стрессом."
ITEM.model = "models/lostsignalproject/items/medical/drink_crow.mdl"

ITEM.sound = "stalkersound/inv_drink_tea.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 180

ITEM.quantity = 2
ITEM.restore = 60
ITEM.toxin = 5
--ITEM.psyheal = 12

ITEM.weight = 0.040
ITEM.flatweight = 0.080

ITEM.exRender = false
ITEM.iconCam = {
	pos = Vector(-200, 0, 0),
	ang = Angle(-0.7, -0.02, 0),
	fov = 2.17
}


function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc2(tooltip, "Успокоительное", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/psiprot.png"))
	ix.util.PropertyDesc2(tooltip, "Жидкость", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/impact.png"))
end

ITEM.functions.use = {
	name = "Употребить",
	icon = "icon16/stalker/swallow.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)

		ix.util.PlayerPerformBlackScreenAction(item.player, "Употребление...", 6, function(player) 
			player:AddBuff("buff_psyheal", 30, { amount = item.restore/60 })
			ix.chat.Send(player, "me", "достаёт кружку травяного чая и быстро выпивает её.")
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