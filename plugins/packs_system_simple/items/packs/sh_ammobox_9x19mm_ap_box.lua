ITEM.name = "Патроны 9x19 мм (ПБМ гж)"
ITEM.description = "Цинк с патронами."
ITEM.longdesc = "Патрон 9x19 мм Парабеллум ПБП гж (Индекс ГРАУ - 7Н31) с бронебойной пулей массой 8 грамма с сердечником из закаленной углеродистой стали, в плакированной томпаком стальной оболочке, в биметаллической гильзе. Конструкция пули основана на опыте с различными бронебойными пистолетными патронами в конце 1990-х годов, направленных на нейтрализацию противника, оснащенного броней базового и среднего уровня защиты, а также способности пробивать легкие укрытия и автомобили, обладая при этом высокой начальной скоростью."
ITEM.model = "models/lostsignalproject/items/misc/small_wood_box.mdl"
ITEM.category = "Kits"

ITEM.width = 2
ITEM.height = 1
ITEM.price = 32400

ITEM.items = {
	"ammobox_9x19mm_ap",
	"ammobox_9x19mm_ap",
	"ammobox_9x19mm_ap",
	"ammobox_9x19mm_ap",
	"ammobox_9x19mm_ap",

	"ammobox_9x19mm_ap",
	"ammobox_9x19mm_ap",
	"ammobox_9x19mm_ap",
	"ammobox_9x19mm_ap",
	"ammobox_9x19mm_ap",

	"ammobox_9x19mm_ap",
	"ammobox_9x19mm_ap",
	"ammobox_9x19mm_ap",
	"ammobox_9x19mm_ap",
	"ammobox_9x19mm_ap",
	
	"ammobox_9x19mm_ap",
	"ammobox_9x19mm_ap",
	"ammobox_9x19mm_ap",
	"ammobox_9x19mm_ap",
	"ammobox_9x19mm_ap"
	
}


function ITEM:GetDescription()
	local quant = self:GetData("quantity", self.ammoAmount or self.quantity or 0)
	local quantdesc = ""
	local invdesc = ""
	if self.longdesc then
		invdesc = "\n\n"..(self.longdesc)
	end

	if self.quantdesc then
		quantdesc = "\n\n"..Format(self.quantdesc, quant)
	end

	if (self.entity) then
		return (self.description)
	else
        return (self.description..quantdesc..invdesc)
	end
end

function ITEM:PopulateTooltip(tooltip)
    if !self.entity then
        ix.util.PropertyDesc(tooltip, "Пистолетный патрон калибра 9x18 мм", Color(64, 224, 208))
        ix.util.PropertyDesc(tooltip, "Содержит порох", Color(64, 224, 208))
        ix.util.PropertyDesc(tooltip, "Пистолетная гильза", Color(64, 224, 208))
    end

    if (self.PopulateTooltipIndividual) then
      self:PopulateTooltipIndividual(tooltip)
    end
end

ITEM.functions.Open = {
	name = "Распаковать",
    icon = "icon16/stalker/unlock.png",
    sound = "stalkersound/inv_ruck.mp3",
	OnRun = function(itemTable)
		local client = itemTable.player
		local character = client:GetCharacter()

		for k, v in ipairs(itemTable.items) do
			if (!character:GetInventory():Add(v)) then
					ix.item.Spawn(v, client)
			end
		end
	end
}