ITEM.name = "Антисептик"
ITEM.description = "Бутылка с антисептиком. Пахнет спиртом."
ITEM.longdesc = "Противогнилостное средство, предназначенное для предотвращения процессов разложения на поверхности открытых ран, например в ранах, образующихся после больших операций или ушибов, или для задержания уже начавшихся изменений в крови. Антисептики применяются для обработки рук хирургов и медицинского персонала перед контактом с пациентами. Подойдёт, чтобы обработать собственные раны."
ITEM.model = "models/lostsignalproject/items/consumable/tea.mdl"

ITEM.sound = "stasound/antiseptic_usage.ogg"

ITEM.width = 1
ITEM.height = 2
ITEM.price = 470

ITEM.quantity = 3
ITEM.restore = 60
--ITEM.toxin = -100
--ITEM.psyheal = 12

ITEM.weight = 0.050
ITEM.flatweight = 0.080

ITEM.exRender = false
ITEM.iconCam = {
	pos = Vector(0, 200, 0),
	ang = Angle(-1.66, 269.99, 0),
	fov = 2.01
}


function ITEM:PopulateTooltipIndividual(tooltip)
	ix.util.PropertyDesc2(tooltip, "Антисептик", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/hpregen.png"))
	ix.util.PropertyDesc2(tooltip, "Жидкость", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/impact.png"))
end

ITEM.functions.use = {
	name = "Обработать раны",
	icon = "icon16/stalker/swallow.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)

		ix.util.PlayerPerformBlackScreenAction(item.player, "Обработка ран...", 6, function(player) 
			player:AddBuff("buff_slowheal", 40, { amount = item.restore/60 }) --Делим на два.
			ix.chat.Send(player, "me", "достаёт бутылку антисептика и обрабатывает свои раны, заметно морщясь от боли и издавая приглушённые стоны.")
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