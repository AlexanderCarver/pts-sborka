ITEM.name = "Патроны 5.45x39 мм (БС)"
ITEM.description = "Цинк с патронами."
ITEM.longdesc = "Патрон 5.45x39 мм БС гс (Индекс ГРАУ — 7Н24) со специальной бронебойной пулей БС массой 10 грамм с заостренным сердечником из карбида вольфрама. с биметаллической оболочкой. в стальной гильзе. Пуля БС (Бронебойный Сердечник) была разработана в ЦНИИТочМаш в 1998 году для значительного увеличения пробивной способности российского оружия 5.45х39 мм. что привело к выдающимся результатам против некоторых специализированных моделей 5-6 класса защиты. несмотря на относительно низкую начальную скорость пули по сравнению с другими патронами. Однако. из-за своей конструкции. она имеет высокую вероятность отскока от различных поверхностей."
ITEM.model = "models/lostsignalproject/items/misc/small_wood_box.mdl"
ITEM.category = "Kits"

ITEM.width = 2
ITEM.height = 1
ITEM.price = 28800

ITEM.items = {
	"ammobox_545x39mm_ap",
	"ammobox_545x39mm_ap",
	"ammobox_545x39mm_ap",
	"ammobox_545x39mm_ap",
	"ammobox_545x39mm_ap",

	"ammobox_545x39mm_ap",
	"ammobox_545x39mm_ap",
	"ammobox_545x39mm_ap",
	"ammobox_545x39mm_ap",
	"ammobox_545x39mm_ap",

	"ammobox_545x39mm_ap",
	"ammobox_545x39mm_ap",
	"ammobox_545x39mm_ap",
	"ammobox_545x39mm_ap",
	"ammobox_545x39mm_ap",
	
	"ammobox_545x39mm_ap",
	"ammobox_545x39mm_ap",
	"ammobox_545x39mm_ap",
	"ammobox_545x39mm_ap",
	"ammobox_545x39mm_ap"
	
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
        ix.util.PropertyDesc(tooltip, "Штурмовой патрон калибра 5.45x39 мм", Color(64, 224, 208))
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