ITEM.name = "Патроны 7.62x54 мм (Т-46М гж)"
ITEM.description = ""
ITEM.quantdesc =  "Количество патронов: %s штук."
ITEM.longdesc = "Патрон 7.62х54ммR Т-46М гж (Индекс ГРАУ - 7Т2М) с трассирующей пулей массой 25 грамм со свинцовым сердечником, в биметаллической оболочке, в биметаллической гильзе. Предназначен для целеуказания и корректировки огня в бою (цвет трассера: Зеленый). Является модернизирацией патрона Т-46 (Индекс ГРАУ - 7Т2) и обеспечивает возможность отслеживания на более дальних дистанциях. По баллистической эффективности аналогичен патрону ЛПС гж (Индекс ГРАУ - 57-Н-323С). Несмотря на относительно простую конструкцию, пуля имеет хорошую пробивную способность против брони базового и среднего уровня защиты и значительное останавливающее воздействие. Однако она имеет высокую вероятность отскока от различных поверхностей."

ITEM.ammo = "7.62x54trgmm"
ITEM.model = "models/lostsignalproject/items/ammo/762x54.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.ammoAmount = 20

ITEM.price = 1040

ITEM.weight = 0.025
ITEM.flatweight = 0.05

function ITEM:PopulateTooltipIndividual(tooltip)
  ix.util.PropertyDesc(tooltip, "Винтовочный патрон калибра 7.62x54 мм", Color(64, 224, 208))
  ix.util.PropertyDesc(tooltip, "Содержит порох", Color(64, 224, 208))
  ix.util.PropertyDesc(tooltip, "Содержит винтовочную гильзу", Color(64, 224, 208))
end

function ITEM:GetWeight()
    return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
  end