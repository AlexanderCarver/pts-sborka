ITEM.name = "9-Вольтовая батарея"
ITEM.description = "Изношенная и грязная, но, похоже, в рабочем состоянии."
ITEM.longdesc = "9-вольтовая батарея, используемая для питания небольших электронных устройств."
ITEM.model = "models/lostsignalproject/items/misc/battery.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 90

ITEM.quantity = 10

ITEM.flatweight = 0
ITEM.weight = 0.053

function ITEM:GetPrice()
	return self.price * self:GetData("quantity", self.quantity)
end

ITEM.functions.combine = {
	OnCanRun = function(item, data)
		if !data then
			return false
		end
		local targetItem = ix.item.instances[data[1]]

		if targetItem.uniqueID == item.uniqueID then
			return true
		else
			return false
		end
	end,
	OnRun = function(item, data)
		local targetItem = ix.item.instances[data[1]]
		local targetQuantDiff = targetItem.quantity - targetItem:GetData("quantity", targetItem.quantity)
		local localQuant = item:GetData("quantity", item.quantity)
		local targetQuant = targetItem:GetData("quantity", targetItem.quantity)
		item.player:EmitSound("stalkersound/inv_properties.mp3", 110)
		if targetQuantDiff >= localQuant then
			targetItem:SetData("quantity", targetQuant + localQuant)
			return true
		else
			item:SetData("quantity", localQuant - targetQuantDiff)
			targetItem:SetData("quantity", targetItem.quantity)
			return false
		end
	end,
}

function ITEM:OnInstanced()
	if (!self:GetData("quantity")) then
		self:SetData("quantity", math.random(2,3))
	end
end