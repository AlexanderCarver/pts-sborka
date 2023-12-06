ITEM.name = "Патроны 5.45x39 мм"
ITEM.description = ""
ITEM.quantdesc =  "Количество патронов: %s штук."
ITEM.longdesc = "Малоимпульсный советский промежуточный унитарный патрон центрального воспламенения. Малокалиберная пуля с высокой начальной скоростью обеспечивает высокую настильность траектории, обладает неплохим пробивным действием и значительной убойной силой. Малый импульс отдачи в момент выстрела благоприятно сказывается на кучности и меткости стрельбы, а уменьшение массы патрона позволяет стрелку увеличить носимый боезапас."

ITEM.ammo = "5.45x39mm"
ITEM.model = "models/lostsignalproject/items/ammo/545x39.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.ammoAmount = 30

ITEM.price = 1440

ITEM.weight = 0.011
ITEM.flatweight = 0.05

function ITEM:PopulateTooltipIndividual(tooltip)
  ix.util.PropertyDesc(tooltip, "Штурмовой патрон калибра 5.45x39 мм", Color(64, 224, 208))
  ix.util.PropertyDesc(tooltip, "Содержит порох", Color(64, 224, 208))
  ix.util.PropertyDesc(tooltip, "Содержит гильзу", Color(64, 224, 208))
end

function ITEM:GetWeight()
    return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
  end