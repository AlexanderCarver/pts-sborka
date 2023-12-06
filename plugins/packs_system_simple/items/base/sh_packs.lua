ITEM.name = "Kit"
ITEM.description = "Default kit."
ITEM.longdesc = "Long babboy."
ITEM.model = "models/props_junk/garbage_bag001a.mdl"
ITEM.category = "Kits"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 1
ITEM.items = {}

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
        ix.util.PropertyDesc(tooltip, "Патроны ебаные", Color(64, 224, 208))
    end

    if (self.PopulateTooltipIndividual) then
      self:PopulateTooltipIndividual(tooltip)
    end
end

ITEM:Hook("Open", function(item)
	ix.chat.Send(item.player, "me", "вскрывает "..item.name..", укладывая содержимое в свой инвентарь.", false)
end)