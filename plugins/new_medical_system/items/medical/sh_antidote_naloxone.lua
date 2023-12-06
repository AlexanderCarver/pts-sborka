ITEM.name = "Налоксон"
ITEM.description = "Одноразовый шприц с лекарственным средством в герметичной упаковке."
ITEM.longdesc = "Антагонист опиоидных рецепторов, применяется как антидот при передозировках опиоидов, в первую очередь героина. По химической структуре налоксон близок к налорфину. Отличная вещь, если вдруг случился передоз."
ITEM.model = "models/lostsignalproject/items/medical/glucose.mdl"

ITEM.sound = "stalkersound/inv_syringe.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 1280

ITEM.quantity = 1
ITEM.restore = 1
--ITEM.toxin = -100
--ITEM.psyheal = 12

ITEM.weight = 0.015
ITEM.flatweight = 0.015

ITEM.exRender = false
ITEM.iconCam = {
	pos = Vector(-200, 0, 0),
	ang = Angle(0, 0, 0),
	fov = 1.67
}

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc2(tooltip, "Антидот", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/chemprot.png"))
	ix.util.PropertyDesc2(tooltip, "Инъекция", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/impact.png"))
end

ITEM.functions.use = {
	name = "Употребить",
	icon = "icon16/stalker/swallow.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)

		ix.util.PlayerPerformBlackScreenAction(item.player, "Употребление...", 2, function(player)
			player:AddBuff("buff_toxinremoval", 60, { amount = item.restore/60 }) --Делим на два.
			ix.chat.Send(player, "me", "достаёт шприц с налоксоном и делает себе инъекцию, заметно зажмурившись.")
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