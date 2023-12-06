ITEM.name = "Самодельный бинт"
ITEM.description = "Несколько сложенных вместе тряпок в горизонтальном положении."
ITEM.longdesc = "Связанные вместе куски ткани. Могут использоваться как основное гемостатическое средство."
ITEM.model = "models/illusion/eftcontainers/bandage.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 25

ITEM.quantity = 1
ITEM.restore = 60
--ITEM.psyheal = 12

ITEM.weight = 0.120
ITEM.flatweight = 0.000

ITEM.exRender = false
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 2.43
}


function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc2(tooltip, "Гемостатик (слабый)", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/bleeding.png"))

end

function CheckBleeding(player)
	if ix and ix.Wounds and ix.Wounds.GetBleeding then
		return ix.Wounds:GetBleeding(player) > 0
	else
		return false
	end
end

ITEM.functions.Apply = {
	name = "Перевязка",
	icon = "icon16/stalker/heal.png",
	sound = "stalkersound/inv_bandage.mp3",
	OnRun = function(itemTable)
		local player = itemTable.player
		local quantity = itemTable:GetData("quantity", itemTable.quantity)
		local character = player:GetCharacter()
		if ix.Wounds:GetBleeding(player, true) then -- проверка на наличие кровотечения
			ix.util.PlayerPerformBlackScreenAction(player, "Перевязка...", 8, function()
				if math.random() < 0.3 then
					ix.Wounds:RemoveBleeding(player)
					player:Notify("Вы успешно остановили кровотечение.")
					ix.chat.Send(player, "me", "перевязывает место ранения рваными тряпками, слегка зажмурившись.")
				else
					player:Notify("Не удалось остановить кровотечение.")
					ix.chat.Send(player, "me", "перевязывает место ранения рваными тряпками, слегка зажмурившись.")
				end
			end)
		else
			player:Notify("У вас нет кровотечения.")
		end
		
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