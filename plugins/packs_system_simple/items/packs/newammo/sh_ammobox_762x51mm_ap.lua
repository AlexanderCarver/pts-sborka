ITEM.name = "Патроны 7.62x51 мм (M80)"
ITEM.description = ""
ITEM.quantdesc =  "Количество патронов: %s штук."
ITEM.longdesc = "Патрон 7.62x51 мм НАТО M80 с пулей массой 21 грамм с сердечником из свинцово-сурьмянистого сплава в биметаллической оболочке, в латунной гильзе. Этот патрон был принят в вооруженных силах США в качестве замены патрона 7.62x51 мм НАТО M59 после войны во Вьетнаме в качестве стандартного боеприпаса. Обеспечивает значительное останавливающее воздействие и хорошую пробивную способность против брони базового и среднего уровня защиты. Однако, из-за своей конструкции, пуля имеет высокую вероятность отскока от различных поверхностей."

ITEM.ammo = "7.62x51apmm"
ITEM.model = "models/lostsignalproject/items/ammo/762x51.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.ammoAmount = 20

ITEM.price = 1560

ITEM.weight = 0.021
ITEM.flatweight = 0.05

function ITEM:PopulateTooltipIndividual(tooltip)
  ix.util.PropertyDesc(tooltip, "Винтовочный патрон калибра 7.62x51 мм NATO", Color(64, 224, 208))
  ix.util.PropertyDesc(tooltip, "Содержит порох", Color(64, 224, 208))
  ix.util.PropertyDesc(tooltip, "Содержит винтовочную гильзу", Color(64, 224, 208))
end

function ITEM:GetWeight()
    return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
  end