ITEM.name = "Мелперон"
ITEM.description = "Одноразовый шприц с лекарственным средством в герметичной упаковке."
ITEM.longdesc = "Мелперон является атипичным нейролептиком химического класса бутирофенонов, что роднит его по структуре с типичным нейролептиком галоперидолом."
ITEM.model = "models/lostsignalproject/items/medical/glucose.mdl"

ITEM.sound = "stalkersound/inv_syringe.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 1870

ITEM.quantity = 1
ITEM.restore = 60
--ITEM.toxin = 30
--ITEM.psyheal = 12

ITEM.weight = 0.0004
ITEM.flatweight = 0.010

ITEM.exRender = false
ITEM.iconCam = {
	pos = Vector(-200, 0, 0),
	ang = Angle(0, 0, 0),
	fov = 2.69
}

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc2(tooltip, "Нейролептик", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/man.png"))
	ix.util.PropertyDesc2(tooltip, "Инъекция", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/impact.png"))
end

ITEM.functions.use = {
	name = "Сделать инъекцию",
	icon = "icon16/stalker/swallow.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)

		ix.util.PlayerPerformBlackScreenAction(item.player, "Инъекция...", 2, function(player) 
			player:AddBuff("buff_psysuppress", 900, { amount = item.restore/60 })
			player:AddBuff("debuff_toxinadd", 60, { amount = item.restore/60 }) --Делим на два.
            player:GetCharacter():SatisfyAddictions("Antipsychotic")
			ix.chat.Send(player, "me", "достаёт шприц с мелпероном и делает себе инъекцию, заметно зажмурившись.")
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