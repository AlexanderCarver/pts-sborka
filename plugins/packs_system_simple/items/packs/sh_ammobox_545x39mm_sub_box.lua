ITEM.name = "Патроны 5.45x39 мм (УС)"
ITEM.description = "Цинк с патронами."
ITEM.longdesc = "Тяжеленный патрон 5.45x39 мм УС гс (Индекс ГРАУ - 7У1) с дозвуковой пулей массой 11 грамм с заостренным сердечником из карбида вольфрама с биметаллической оболочкой. в стальной гильзе с уменьшенным зарядом. Патрон УС (Уменьшенной Скорости) был разработан ЦНИИТочМаш в середине 1980-х годов для использования в автоматах АКС-74УБ и АКС-74УБН вместе с глушителем. обеспечивая цикличность стрельбы и снижение шума в дополнение к значительному поражающему воздействию. Но. несмотря на состав пули. она испытывает трудности с пробивной способностью даже против брони базового уровня защиты и. из-за своей конструкции. имеет высокую вероятность отскока от различных поверхностей."
ITEM.model = "models/lostsignalproject/items/misc/small_wood_box.mdl"
ITEM.category = "Kits"

ITEM.width = 2
ITEM.height = 1
ITEM.price = 22680

ITEM.items = {
	"ammobox_545x39mm_sub",
	"ammobox_545x39mm_sub",
	"ammobox_545x39mm_sub",
	"ammobox_545x39mm_sub",
	"ammobox_545x39mm_sub",

	"ammobox_545x39mm_sub",
	"ammobox_545x39mm_sub",
	"ammobox_545x39mm_sub",
	"ammobox_545x39mm_sub",
	"ammobox_545x39mm_sub",

	"ammobox_545x39mm_sub",
	"ammobox_545x39mm_sub",
	"ammobox_545x39mm_sub",
	"ammobox_545x39mm_sub",
	"ammobox_545x39mm_sub",
	
	"ammobox_545x39mm_sub",
	"ammobox_545x39mm_sub",
	"ammobox_545x39mm_sub",
	"ammobox_545x39mm_sub",
	"ammobox_545x39mm_sub"
	
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