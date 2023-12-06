ITEM.name = "Кофеин"
ITEM.description = "Таблетки в хорошо защищенной упаковке."
ITEM.longdesc = "Кофеин в таблетках, который заставляет работать нервную систему с эффективной работоспособностью. В значительной степени снижает сонливость."
ITEM.model = "models/lostsignalproject/items/medical/caffeine.mdl"

ITEM.sound = "stalkersound/inv_eat_pills.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 820

ITEM.quantity = 8
ITEM.restore = 60
--ITEM.toxin = 5
--ITEM.psyheal = 12

ITEM.weight = 0.001
ITEM.flatweight = 0.010

ITEM.exRender = false
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 45),
	fov = 1.7,
}


function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc2(tooltip, "Стимулятор", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/stamina.png"))
	ix.util.PropertyDesc2(tooltip, "Таблетки", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/impact.png"))
end

ITEM.functions.use = {
	name = "Употребить",
	icon = "icon16/stalker/swallow.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)

		ix.util.PlayerPerformBlackScreenAction(item.player, "Употребление...", 4, function(player) 
			player:AddBuff("buff_staminarestore", 40, { amount = item.restore/60 }) --Делим на два.
			player:AddBuff("debuff_toxinadd", 10, { amount = item.restore/60 }) --Делим на два.
			ix.chat.Send(player, "me", "достаёт упаковку кофеина и выдавливает одну из таблеток в свою ладонь, после чего глотает её.")
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