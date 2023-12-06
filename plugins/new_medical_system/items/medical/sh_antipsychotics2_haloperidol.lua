ITEM.name = "Галоперидол"
ITEM.description = "Одноразовый шприц с лекарственным средством в герметичной упаковке."
ITEM.longdesc = "Обладает мощным антипсихотическим действием, умеренным седативным . Механизм антипсихотического действия связан с блокадой дофаминовых рецепторов в мезокортексе и лимбической системе. Блокирует дофаминергическую активность в нигростриальном пути, с чем связаны нарушения со стороны экстрапирамидной системы."
ITEM.model = "models/lostsignalproject/items/medical/glucose.mdl"

ITEM.sound = "stalkersound/inv_syringe.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 2160

ITEM.quantity = 1
ITEM.restore = 60
--ITEM.toxin = 35
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
    ix.util.PropertyDesc2(tooltip, "Нейролептик", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/man.png"))
	ix.util.PropertyDesc2(tooltip, "Инъекция", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/impact.png"))

end

ITEM.functions.use = {
	name = "Сделать инъекцию",
	icon = "icon16/stalker/swallow.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)

		ix.util.PlayerPerformBlackScreenAction(item.player, "Инъекция...", 2, function(player) 
			player:AddBuff("buff_psysuppress", 1200, { amount = item.restore/60 })
			player:AddBuff("debuff_toxinadd", 70, { amount = item.restore/60 }) --Делим на два.
            player:GetCharacter():SatisfyAddictions("Antipsychotic")
			ix.chat.Send(player, "me", "достаёт шприц с галоперидолом и делает себе инъекцию, заметно зажмурившись.")
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