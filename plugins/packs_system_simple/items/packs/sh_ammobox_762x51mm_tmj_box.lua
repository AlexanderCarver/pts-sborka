ITEM.name = "Цинк патронами 7.62x51 мм (M61)"
ITEM.description = ""
ITEM.quantdesc =  "Количество патронов: %s штук."
ITEM.longdesc = "Патрон 7.62x51 мм НАТО M61 с бронебойной пулей массой 21 грамм с сердечником из закаленной стали и плакированной биметаллической оболочкой, в латунной гильзе. Патрон был разработан в 1950-х годах на основе патрона .30-06 Springfield AP M2 для обеспечения вооруженных сил США бронебойной пулей для автоматического оружия 7.62x51 мм НАТО, способной пробивать самую современную специализированную броню 5-6 класса защиты, вдобавок обеспечивая значительное останавливающее воздействие. Однако, из-за своей конструкции, пуля имеет высокую вероятность отскока от различных поверхностей."

ITEM.ammo = "7.62x51tmjmm"
ITEM.model = "models/lostsignalproject/items/misc/small_case.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.ammoAmount = 400

ITEM.price = 23760

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