ITEM.name = "Жгут"
ITEM.description = "Резинка советской эпохи, способная останавить серьёзное кровотечение."
ITEM.longdesc = "Устройство, которое используется для оказания давления на конечность или конечность, чтобы остановить поток крови. Его можно использовать в экстренных случаях, если обычные средства не помогают."
ITEM.model = "models/lostsignalproject/items/medical/army_bandage.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 260

ITEM.quantity = 1
ITEM.restore = 60
--ITEM.psyheal = 12

ITEM.weight = 0.080
ITEM.flatweight = 0.000

ITEM.exRender = false
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, -91.92, 0),
	fov = 3.07
}


function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc2(tooltip, "Гемостатик (эффективный)", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/bleeding.png"))

end

function CheckBleeding(player)
	if ix and ix.Wounds and ix.Wounds.GetBleeding then
		return ix.Wounds:GetBleeding(player) > 0
	else
		return false
	end
end

ITEM.functions.Apply = {
	name = "Наложить жгут",
	icon = "icon16/stalker/heal.png",
	sound = "stalkersound/inv_bandage.mp3",
	OnRun = function(itemTable)
		local player = itemTable.player
		local quantity = itemTable:GetData("quantity", itemTable.quantity)
		local character = player:GetCharacter()

		ix.util.PlayerPerformBlackScreenAction(player, "Наложение жгута...", 4, function(player)
				if math.random() <= 0.9 then
					ix.Wounds:RemoveBleeding(player)
					player:Notify("Вы успешно остановили кровотечение.")
					ix.chat.Send(player, "me", "накладывает жгут на поврежденную конечность, туго затягивая его, чтобы остановить кровотечение.")
				else
					player:Notify("Не удалось остановить кровотечение.")
					ix.chat.Send(player, "me", "накладывает жгут на поврежденную конечность, туго затягивая его, чтобы остановить кровотечение.")
				end
			end)
		
		quantity = quantity - 1
	
		if (quantity >= 1) then
			itemTable:SetData("quantity", quantity)
			return false
		end
	
		return true
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
	end
}