ITEM.name = "Кокаин"
ITEM.description = "Маленькая коробочка чёрного цвета с сюрпризом внутри."
ITEM.longdesc = "Кокаин повышает бдительность, чувство благополучия и эйфории, повышает энергию и длительную активность.Беспокойство, паранойя и неугомонность являются частыми симптомами при частом употреблении.  "
ITEM.model = "models/lostsignalproject/items/medical/cocaine.mdl"

ITEM.sound = "stalkersound/inv_sniff_2.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 720

ITEM.quantity = 3
ITEM.restore = 60
--ITEM.toxin = 5
--ITEM.psyheal = 12

ITEM.weight = 0.015
ITEM.flatweight = 0.030

ITEM.exRender = false
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 45),
	fov = 1.7,
}


function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc2(tooltip, "Стимулятор", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/stamina.png"))
	ix.util.PropertyDesc2(tooltip, "Наркотик", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/psi.png"))
	ix.util.PropertyDesc2(tooltip, "Порошок", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/impact.png"))
end

ITEM.functions.use = {
	name = "Употребить",
	icon = "icon16/stalker/swallow.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)

		ix.util.PlayerPerformBlackScreenAction(item.player, "Употребление...", 6, function(player) 
			player:AddBuff("buff_staminarestore", 100, { amount = item.restore/60 }) --Делим на два.
			player:AddBuff("debuff_psy", 50, { amount = item.restore/60 }) --Делим на два.
			player:AddBuff("debuff_toxinadd", 30, { amount = item.restore/60 }) --Делим на два.
			player:GetCharacter():SatisfyAddictions("MediumDrugs")
			ix.chat.Send(player, "me", "достает небольшой прозрачный пакетик с белым порошком из маленькой чёрной коробочки и, сделав парочку дорожек, смачно занюхивает содержимое, сразу же начав чесать нос.")
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