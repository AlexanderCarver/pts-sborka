ITEM.name = "Анальгин"
ITEM.description = "Таблетки в хорошо защищенной упаковке."
ITEM.longdesc = "Анальгетик и антипиретик из группы пиразолонов в ампиронсульфонатном семействе лекарств. Во многих странах изъят из оборота в связи с риском развития агранулоцитоза, однако всё ещё используется в пределах Территории."
ITEM.model = "models/lostsignalproject/items/medical/sleeping_pills.mdl"

ITEM.sound = "stalkersound/inv_eat_pills.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 710

ITEM.quantity = 10
ITEM.restore = 60
--ITEM.toxin = 5
--ITEM.psyheal = 12

ITEM.weight = 0.001
ITEM.flatweight = 0.010

ITEM.exRender = false
ITEM.iconCam = {
	pos = Vector(-200, 0, 0),
	ang = Angle(0, 0, 0),
	fov = 1.67
}


function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc2(tooltip, "Обезболивающее", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/hpregen.png"))
	ix.util.PropertyDesc2(tooltip, "Таблетки", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/impact.png"))
end

ITEM.functions.use = {
	name = "Употребить",
	icon = "icon16/stalker/swallow.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)

		ix.util.PlayerPerformBlackScreenAction(item.player, "Употребление...", 4, function(player) 
			player:AddBuff("buff_slowheal", 30, { amount = item.restore/60 }) --Делим на два.
			player:AddBuff("debuff_toxinadd", 10, { amount = item.restore/60 }) --Делим на два.
			ix.chat.Send(player, "me", "достаёт упаковку анальгина и выдавливает одну из таблеток в свою ладонь, после чего глотает её.")
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