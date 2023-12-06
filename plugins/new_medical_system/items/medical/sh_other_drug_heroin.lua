ITEM.name = "Героин"
ITEM.description = "Маленький шприц с мутной жидкостью."
ITEM.longdesc = "На Территории героин, как правило, используют как обезболивающее и успокоительное. При частом употреблении может развиваться органическое поражение головного мозга."
ITEM.model = "models/lostsignalproject/items/medical/glucose.mdl"

ITEM.sound = "stalkersound/inv_syringe.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 550

ITEM.quantity = 1
ITEM.restore = 60
--ITEM.toxin = 40
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
    ix.util.PropertyDesc2(tooltip, "Болеутоляющее", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/hpregen.png"))
    ix.util.PropertyDesc2(tooltip, "Наркотик", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/psi.png"))
	ix.util.PropertyDesc2(tooltip, "Инъекция", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/impact.png"))
end

ITEM.functions.use = {
	name = "Сделать инъекцию",
	icon = "icon16/stalker/swallow.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)

		ix.util.PlayerPerformBlackScreenAction(item.player, "Инъекция...", 2, function(player) 
			player:AddBuff("buff_rapidheal", 45, { amount = item.restore/60 }) --Делим на два.
			player:AddBuff("debuff_psy", 40, { amount = item.restore/60 }) --Делим на два.
			player:AddBuff("debuff_toxinadd", 100, { amount = item.restore/60 }) --Делим на два.
            player:GetCharacter():SatisfyAddictions("StrongDrugs")
			ix.chat.Send(player, "me", "достаёт шприц с героином и делает себе инъекцию, заметно зажмурившись.")
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