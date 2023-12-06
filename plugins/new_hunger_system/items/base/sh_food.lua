ITEM.name = "Food base"
ITEM.description = "This is base a food."
ITEM.longdesc = "This a long desc of base of food. SHIIIIET."
ITEM.model = "models/props_junk/popcan01a.mdl"

ITEM.width = 1
ITEM.height = 1

ITEM.quantity = 1

ITEM.destroy_item = true

-- В процентах от -100 до 100.
ITEM.thirst_amount = 0
ITEM.hunger_amount = 0
ITEM.drunk_amount = 0

ITEM.weight = 0
ITEM.flatweight = 0

ITEM.category = "Food"

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

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		draw.SimpleText(item:GetData("quantity", item.quantity).."/"..item.quantity, "stalkerregularinvfont", 3, h - 1, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, color_black)
	end
end

function ITEM:PopulateTooltip(tooltip)
    if (self.PopulateTooltipIndividual) then
      self:PopulateTooltipIndividual(tooltip)
    end
end

function ITEM:OnInstanced(invID, x, y, item)
	item:SetData("quantity", item.quantity or 1)
end

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.quantity))
end