ITEM.name = "Патроны 5.56x45 мм (М200)"
ITEM.description = "Цинк с патронами."
ITEM.longdesc = "Холостой патрон предназначен для имитации звукового эффекта стрельбы из всех видов штатного оружия под патроны 5.56 мм. Патрон используется с дульной втулкой. которая обеспечивает давление пороховых газов. необходимое для работы автоматики оружия."
ITEM.model = "models/lostsignalproject/items/misc/small_wood_box.mdl"
ITEM.category = "Kits"

ITEM.width = 2
ITEM.height = 1
ITEM.price = 12960

ITEM.items = {
	"ammobox_556x45mm_blk",
	"ammobox_556x45mm_blk",
	"ammobox_556x45mm_blk",
	"ammobox_556x45mm_blk",
	"ammobox_556x45mm_blk",

	"ammobox_556x45mm_blk",
	"ammobox_556x45mm_blk",
	"ammobox_556x45mm_blk",
	"ammobox_556x45mm_blk",
	"ammobox_556x45mm_blk",

	"ammobox_556x45mm_blk",
	"ammobox_556x45mm_blk",
	"ammobox_556x45mm_blk",
	"ammobox_556x45mm_blk",
	"ammobox_556x45mm_blk",
	
	"ammobox_556x45mm_blk",
	"ammobox_556x45mm_blk",
	"ammobox_556x45mm_blk",
	"ammobox_556x45mm_blk",
	"ammobox_556x45mm_blk"
	
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