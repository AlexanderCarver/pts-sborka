ITEM.name = "Сигареты “Lucky Strike”"
ITEM.description = "Пачка сигарет. Всё не так уж плохо на сегодняшний день."
ITEM.longdesc = "Отдельные сигареты этой марки часто называют в просторечии ”Лаки”. На протяжении всей своей 150-летней истории популярность Lucky Strike на рынке колебалась, и в 1930-1940-е годы бренд достиг своего пика, став одним из самых продаваемых брендов сигарет в Соединенных Штатах."
ITEM.model = "models/lostsignalproject/items/consumable/cigarettes_lucky.mdl"

ITEM.sound = "stalkersound/inv_smoke.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 420

ITEM.quantity = 20
ITEM.restore = 60
--ITEM.toxin = 5
--ITEM.psyheal = 12

ITEM.weight = 0.001
ITEM.flatweight = 0.008

ITEM.exRender = false
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 1.71
}




function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc2(tooltip, "Никотин", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/stamina.png"))
	ix.util.PropertyDesc2(tooltip, "Успокоительное", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/psiprot.png"))
end

ITEM.functions.use = {
	name = "Покурить",
	icon = "icon16/stalker/smoke.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)

		ix.util.PlayerPerformBlackScreenAction(item.player, "Употребление...", 8, function(player) 
			player:AddBuff("buff_psyheal", 20, { amount = item.restore/60 }) --Делим на два.
			player:AddBuff("debuff_slowdamage", 10, { amount = item.restore/60 }) --Делим на два.
			player:GetCharacter():SatisfyAddictions("LightSmokes")
			ix.chat.Send(player, "me", "достает пачку сигарет Лаки Страйк и берет одну из них в рот, после чего закуривает, наполняя воздух горьким табачным дымом. Сигареты на вкус как табак, но более лёгкий, нежели чем обычный табак. Странно...")
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