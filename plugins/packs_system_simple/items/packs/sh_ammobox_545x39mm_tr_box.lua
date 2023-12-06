ITEM.name = "Патроны 5.45x39 мм (Т гс)"
ITEM.description = "Цинк с патронами."
ITEM.longdesc = "Патрон 5.45х39 мм Т гс (Индекс ГРАУ - 7Т3) с трассирующей пулей массой 13 грамм со свинцовым сердечником. в биметаллической оболочке. в стальной гильзе. Предназначен для целеуказания и корректировки огня в бою (цвет трассера: Красный). Патрон Т (Трассирующий) был представлен в 1974 году вместе с патроном ПС гс (Индекс ГРАУ - 7Н6) для обеспечения возможности отслеживания стрельбы для вооружения 5.45х39 мм. а также хорошей пробивной и поражающей способности против брони базового уровня защиты. Однако. из-за своей конструкции. пуля имеет высокую вероятность отскока от различных поверхностей."
ITEM.model = "models/lostsignalproject/items/misc/small_wood_box.mdl"
ITEM.category = "Kits"

ITEM.width = 2
ITEM.height = 1
ITEM.price = 21600

ITEM.items = {
	"ammobox_545x39mm_tr",
	"ammobox_545x39mm_tr",
	"ammobox_545x39mm_tr",
	"ammobox_545x39mm_tr",
	"ammobox_545x39mm_tr",

	"ammobox_545x39mm_tr",
	"ammobox_545x39mm_tr",
	"ammobox_545x39mm_tr",
	"ammobox_545x39mm_tr",
	"ammobox_545x39mm_tr",

	"ammobox_545x39mm_tr",
	"ammobox_545x39mm_tr",
	"ammobox_545x39mm_tr",
	"ammobox_545x39mm_tr",
	"ammobox_545x39mm_tr",
	
	"ammobox_545x39mm_tr",
	"ammobox_545x39mm_tr",
	"ammobox_545x39mm_tr",
	"ammobox_545x39mm_tr",
	"ammobox_545x39mm_tr"
	
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