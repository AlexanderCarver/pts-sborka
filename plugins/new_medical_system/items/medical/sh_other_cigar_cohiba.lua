ITEM.name = "Сигара “Cohiba”"
ITEM.description = "Кубинская сигара, что пахнет черносливом и дубом."
ITEM.longdesc = "Скрутка из листьев табака цилиндрической (или близкой к ней) формы, которую можно курить в том виде, как она есть. Первые сигары стали набирать популярность ещё в XVII веке в среде испанских конкистадоров, спустя сотню лет появились в Европе, а после отмены испанской монополии на кубинский табак в 1817 году распространились по всему миру. Вы очень богаты, если у Вас имеется подобное курево…"
ITEM.model = "models/lostsignalproject/items/consumable/cigar.mdl"

ITEM.sound = "stalkersound/inv_smoke.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 520

ITEM.quantity = 1
ITEM.restore = 60
--ITEM.toxin = 5
--ITEM.psyheal = 12

ITEM.weight = 0.017
ITEM.flatweight = 0.000

ITEM.exRender = false
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 2.39
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

		ix.util.PlayerPerformBlackScreenAction(item.player, "Употребление...", 12, function(player) 
			player:AddBuff("buff_psyheal", 60, { amount = item.restore/60 }) --Делим на два.
			player:AddBuff("debuff_slowdamage", 20, { amount = item.restore/60 }) --Делим на два.
			player:GetCharacter():SatisfyAddictions("SpecialSmokes")
			ix.chat.Send(player, "me", "достает сигару, откусывает заднюю часть зубами и закуривает, испуская густой табачным дым горького вкуса.")
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