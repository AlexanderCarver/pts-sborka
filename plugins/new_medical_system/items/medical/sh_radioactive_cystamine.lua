ITEM.name = "Цистамин"
ITEM.description = "Таблетки в хорошо защищенной упаковке."
ITEM.longdesc = "Вещество-радиопротектор, ослабляет негативное воздействие ионизирующего излучения на организм."
ITEM.model = "models/lostsignalproject/items/medical/radioprotector.mdl"

ITEM.sound = "stalkersound/inv_eat_pills.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 1100

ITEM.quantity = 2
ITEM.restore = 60
ITEM.toxin = 5
--ITEM.psyheal = 12

ITEM.weight = 0.002
ITEM.flatweight = 0.010

ITEM.exRender = false
ITEM.iconCam = {
	pos = Vector(-200, 0, 0),
	ang = Angle(-0.02, -0.01, 0),
	fov = 1.71
}


function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc2(tooltip, "Радиопротектор", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/radprot.png"))
	ix.util.PropertyDesc2(tooltip, "Таблетки", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/impact.png"))
end

ITEM.functions.use = {
	name = "Употребить",
	icon = "icon16/stalker/swallow.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)

		ix.util.PlayerPerformBlackScreenAction(item.player, "Употребление...", 8, function(player) 
			player:AddBuff("buff_radiationremoval", 30, { amount = item.restore/60 })
			ix.chat.Send(player, "me", "достаёт упаковку цистамина и выдавливает большую таблетку в свою ладонь, после чего с трудом глотает её.")
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