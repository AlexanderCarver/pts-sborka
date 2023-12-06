ITEM.name = "Милнаципран"
ITEM.description = "Таблетки в хорошо защищенной упаковке."
ITEM.longdesc = "Лекарственное средство, антидепрессант группы селективных ингибиторов обратного захвата серотонина и норадреналина. Обладает более выраженной норадренергической, чем серотонинергической активностью."
ITEM.model = "models/lostsignalproject/items/medical/cat_eye.mdl"

ITEM.sound = "stalkersound/inv_eat_pills.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 1820

ITEM.quantity = 10
ITEM.restore = 60
--ITEM.toxin = 25
--ITEM.psyheal = 12

ITEM.weight = 0.001
ITEM.flatweight = 0.010

ITEM.exRender = false
ITEM.iconCam = {
	pos = Vector(-200, 0, 0),
	ang = Angle(0, -0.02, 0),
	fov = 1.83
}

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc2(tooltip, "Антидепрессант (сильный)", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/psiprot.png"))
	ix.util.PropertyDesc2(tooltip, "Таблетки", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/impact.png"))
end

ITEM.functions.use = {
	name = "Употребить",
	icon = "icon16/stalker/swallow.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)

		ix.util.PlayerPerformBlackScreenAction(item.player, "Употребление...", 4, function(player) 
			player:AddBuff("buff_psyheal", 120, { amount = item.restore/60 })
			player:AddBuff("debuff_toxinadd", 50, { amount = item.restore/60 }) --Делим на два.
            player:GetCharacter():SatisfyAddictions("StrongAntidepressants")
			ix.chat.Send(player, "me", "достаёт упаковку милнаципрана и выдавливает одну из таблеток в свою ладонь, после чего глотает её.")
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