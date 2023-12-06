ITEM.name = "Оксикодон"
ITEM.description = "Одноразовый шприц с лекарственным средством в герметичной упаковке."
ITEM.longdesc = "Обезболивающий препарат, полусинтетический опиоид, получаемый из тебаина. Оксикодон обычно выписывается для облегчения умеренной или сильной боли."
ITEM.model = "models/lostsignalproject/items/medical/glucose.mdl"

ITEM.sound = "stalkersound/inv_syringe.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 1650

ITEM.quantity = 1
ITEM.restore = 60
--ITEM.toxin = 40
--ITEM.psyheal = 12

ITEM.weight = 0.015
ITEM.flatweight = 0.015

ITEM.exRender = false
ITEM.iconCam = {
	pos = Vector(-200, 0, 0),
	ang = Angle(0, 0, 0),
	fov = 2.69
}

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc2(tooltip, "Болеутоляющее", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/hpregen.png"))
    ix.util.PropertyDesc2(tooltip, "Опиат (сильный)", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/psi.png"))
	ix.util.PropertyDesc2(tooltip, "Инъекция", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/impact.png"))
end

ITEM.functions.use = {
	name = "Сделать инъекцию",
	icon = "icon16/stalker/swallow.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)

		ix.util.PlayerPerformBlackScreenAction(item.player, "Инъекция...", 2, function(player) 
			player:AddBuff("buff_fastheal", 40, { amount = item.restore/60 }) --Делим на два.
			player:AddBuff("debuff_toxinadd", 80, { amount = item.restore/60 }) --Делим на два.
            player:GetCharacter():SatisfyAddictions("MediumDrugs")
			ix.chat.Send(player, "me", "достаёт шприц с оксикодоном и делает себе инъекцию, заметно зажмурившись.")
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