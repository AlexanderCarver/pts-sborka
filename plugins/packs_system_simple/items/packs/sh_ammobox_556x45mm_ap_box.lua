ITEM.name = "Патроны 5.56x45 мм (M855)"
ITEM.description = "Цинк с патронами."
ITEM.longdesc = "Патрон 5.56x45 мм НАТО M855 с пулей массой 12 грамм со стальным наконечником-пенетратором над свинцовым сердечником. с медной оболочкой. в латунной гильзе. Патрон был разработан в 1980-х годах как эквивалент патрона FN SS109 для вооружения 5.56x45 мм. используемого в армии США. Благодаря своей конструкции. пуля в этом патроне обладает хорошей пробивной и поражающей способностью против брони базового уровня защиты. однако имеет высокую вероятность отскока от различных поверхностей."
ITEM.model = "models/lostsignalproject/items/misc/small_wood_box.mdl"
ITEM.category = "Kits"

ITEM.width = 2
ITEM.height = 1
ITEM.price = 32400

ITEM.items = {
	"ammobox_556x45mm_ap",
	"ammobox_556x45mm_ap",
	"ammobox_556x45mm_ap",
	"ammobox_556x45mm_ap",
	"ammobox_556x45mm_ap",

	"ammobox_556x45mm_ap",
	"ammobox_556x45mm_ap",
	"ammobox_556x45mm_ap",
	"ammobox_556x45mm_ap",
	"ammobox_556x45mm_ap",

	"ammobox_556x45mm_ap",
	"ammobox_556x45mm_ap",
	"ammobox_556x45mm_ap",
	"ammobox_556x45mm_ap",
	"ammobox_556x45mm_ap",
	
	"ammobox_556x45mm_ap",
	"ammobox_556x45mm_ap",
	"ammobox_556x45mm_ap",
	"ammobox_556x45mm_ap",
	"ammobox_556x45mm_ap"
	
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
        ix.util.PropertyDesc(tooltip, "Штурмовой патрон калибра 5.56x45 мм", Color(64, 224, 208))
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