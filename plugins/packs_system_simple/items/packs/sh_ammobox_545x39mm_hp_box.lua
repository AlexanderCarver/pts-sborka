ITEM.name = "Патроны 5.45x39 мм (HP)"
ITEM.description = "Цинк с патронами."
ITEM.longdesc = "Патрон 5.45x39 мм с экспансивной пулей (Hollow Point - Экспансивная Полость) массой 11 грамм со свинцовым сердечником. с биметаллической полуоболочкой. в стальной гильзе. Предназначен для охоты. обороны дома и тренировочной стрельбы. Пуля обладает обильным расширением и энергией удара. что придает ей исключительную поражающую способность и травмирующее воздействие на цель после удара."
ITEM.model = "models/lostsignalproject/items/misc/small_wood_box.mdl"
ITEM.category = "Kits"

ITEM.width = 2
ITEM.height = 1
ITEM.price = 27000

ITEM.items = {
	"ammobox_545x39mm_hp",
	"ammobox_545x39mm_hp",
	"ammobox_545x39mm_hp",
	"ammobox_545x39mm_hp",
	"ammobox_545x39mm_hp",

	"ammobox_545x39mm_hp",
	"ammobox_545x39mm_hp",
	"ammobox_545x39mm_hp",
	"ammobox_545x39mm_hp",
	"ammobox_545x39mm_hp",

	"ammobox_545x39mm_hp",
	"ammobox_545x39mm_hp",
	"ammobox_545x39mm_hp",
	"ammobox_545x39mm_hp",
	"ammobox_545x39mm_hp",
	
	"ammobox_545x39mm_hp",
	"ammobox_545x39mm_hp",
	"ammobox_545x39mm_hp",
	"ammobox_545x39mm_hp",
	"ammobox_545x39mm_hp"
	
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