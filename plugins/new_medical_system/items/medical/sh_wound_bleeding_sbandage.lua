ITEM.name = "Стерильный бинт"
ITEM.description = "Полоска стерильной ткани, в старой советской упаковке."
ITEM.longdesc = "Тканая полоска с абсорбирующим барьером для предотвращения прилипания к ранам. Используется как основное гемостатическое средство."
ITEM.model = "models/lostsignalproject/items/medical/bandage.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 210

ITEM.toxin = 0
ITEM.quantity = 1
ITEM.restore = 60
--ITEM.psyheal = 12

ITEM.weight = 0.120
ITEM.flatweight = 0.000

ITEM.exRender = false
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 89.68, 0),
	fov = 2.85
}


function ITEM:PopulateTooltipIndividual(tooltip)
	ix.util.PropertyDesc2(tooltip, "Антисептик", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/hpregen.png"))
    ix.util.PropertyDesc2(tooltip, "Гемостатик (средний)", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/bleeding.png"))

end

ITEM.functions.Apply = {
	name = "Перевязка",
	icon = "icon16/stalker/heal.png",
	sound = "stalkersound/inv_bandage.mp3",
	OnRun = function(itemTable)
		local player = itemTable.player
		local quantity = itemTable:GetData("quantity", itemTable.quantity)
		local character = player:GetCharacter()

		ix.util.PlayerPerformBlackScreenAction(player, "Перевязка...", 6, function(player)
			player:AddBuff("buff_slowheal", 40, { amount = itemTable.restore/60 }) --Делим на два.
				if math.random() <= 0.6 then
					ix.Wounds:RemoveBleeding(player)
					player:Notify("Вы успешно остановили кровотечение.")
					ix.chat.Send(player, "me", "перевязывает место ранения стерильным бинтом, слегка зажмурившись и крепко затягивая кровоточащую рану.")
				else
					player:Notify("Не удалось остановить кровотечение.")
					ix.chat.Send(player, "me", "перевязывает место ранения стерильным бинтом, слегка зажмурившись и крепко затягивая кровоточащую рану")
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