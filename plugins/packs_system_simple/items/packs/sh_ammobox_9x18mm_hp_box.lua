ITEM.name = "Патроны 9x18 мм (П8 гж)"
ITEM.description = "Цинк с патронами."
ITEM.longdesc = "Патрон 9х18 мм ПМ СП8 гж с хрупкой экспансивной пулей массой 9 грамм с полимерным сердечником в головной части и свинцовым сердечником в хвостовой части, с латунной полуоболочкой, в биметаллической гильзе с уменьшенным зарядом. Разработан в середине 80-х годов в ЦНИИТочМаш для создания патрона с низкой бронепробиваемостью, позволяющего свести к минимуму разрушение и пробивание объектов с низкой структурной прочностью (например во время контртеррористических операций на самолетах) и при этом обеспечивающего значительное останавливающее и травмирующее воздействие при попадании."
ITEM.model = "models/lostsignalproject/items/misc/small_wood_box.mdl"
ITEM.category = "Kits"

ITEM.width = 2
ITEM.height = 1
ITEM.price = 23040

ITEM.items = {
	"ammobox_9x18mm_hp",
	"ammobox_9x18mm_hp",
	"ammobox_9x18mm_hp",
	"ammobox_9x18mm_hp",
	"ammobox_9x18mm_hp",

	"ammobox_9x18mm_hp",
	"ammobox_9x18mm_hp",
	"ammobox_9x18mm_hp",
	"ammobox_9x18mm_hp",
	"ammobox_9x18mm_hp",

	"ammobox_9x18mm_hp",
	"ammobox_9x18mm_hp",
	"ammobox_9x18mm_hp",
	"ammobox_9x18mm_hp",
	"ammobox_9x18mm_hp",
	
	"ammobox_9x18mm_hp",
	"ammobox_9x18mm_hp",
	"ammobox_9x18mm_hp",
	"ammobox_9x18mm_hp",
	"ammobox_9x18mm_hp"
	
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