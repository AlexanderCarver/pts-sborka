ITEM.name = "Медицинская шина"
ITEM.description = "Твердая и надежная ткань для фиксации конечностей."
ITEM.longdesc = "Фиксатор для различных частей тела, предназначенный для профилактики и лечения травм и заболеваний костной системы. Отлично помогает восстановить подвижность повреждённых конечностей."
ITEM.model = "models/carlsmei/escapefromtarkov/medical/alusplint.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 400

ITEM.quantity = 1
ITEM.restore = 60
--ITEM.psyheal = 12

ITEM.weight = 0.240
ITEM.flatweight = 0.000

ITEM.exRender = false
ITEM.iconCam = {
	pos = Vector(65.63, -188.93, -0.19),
	ang = Angle(0.02, -251, 0),
	fov = 4.54
}


function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc2(tooltip, "Фиксатор", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/runspeed.png"))

end

function CheckBleeding(player)
	if ix and ix.Wounds and ix.Wounds.GetBleeding then
		return ix.Wounds:GetBleeding(player) > 0
	else
		return false
	end
end

ITEM.functions.Apply = {
	name = "Наложить шину",
	icon = "icon16/stalker/heal.png",
	sound = "stalkersound/inv_bandage.mp3",
	OnRun = function(itemTable)
		local player = itemTable.player
		local quantity = itemTable:GetData("quantity", itemTable.quantity)
		local character = player:GetCharacter()

		ix.util.PlayerPerformBlackScreenAction(player, "Наложение шины...", 8, function(player)
					ix.Wounds:RemoveFracture(player)
						player:Notify("Вы успешно зафиксировали повреждённую ногу.")
					ix.chat.Send(player, "me", "накладывает шину на поврежденную конечность, туго затягивая её и фиксируя её положение.")
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