ITEM.name = "Самокрутка из самосбора"
ITEM.description = "Самодельная сигарета с сюрпризом внутри."
ITEM.longdesc = "Самокрутка со сбором трав, изготовленная из обычной бумаги. В принципе, она немного слабее гашиша, но тоже сойдёт, так как травники не зря старались."
ITEM.model = "models/lostsignalproject/items/medical/joint.mdl"

ITEM.sound = "stalkersound/inv_smoke.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 520

ITEM.quantity = 1
ITEM.restore = 60
--ITEM.toxin = 5
--ITEM.psyheal = 12

ITEM.weight = 0.003
ITEM.flatweight = 0.000

ITEM.exRender = false
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 2.39
}



function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc2(tooltip, "Наркотик", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/psi.png"))
	ix.util.PropertyDesc2(tooltip, "Успокоительное", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/psiprot.png"))
end

ITEM.functions.use = {
	name = "Покурить",
	icon = "icon16/stalker/swallow.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)

		ix.util.PlayerPerformBlackScreenAction(item.player, "Употребление...", 12, function(player) 
			player:AddBuff("buff_psyheal", 40, { amount = item.restore/60 }) --Делим на два.
			player:AddBuff("debuff_slowdamage", 30, { amount = item.restore/60 }) --Делим на два.
			player:GetCharacter():SatisfyAddictions("LightDrugs")
			ix.chat.Send(player, "me", "достает самокрутку самосбора, после чего закуривает, испуская сладковатый дым вокруг себя. От неё слегка перехватывает дыхание, но чувство такое, будто бы вокруг пахнет мятой...")
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