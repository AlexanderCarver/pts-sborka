ITEM.name = "Цинк с патронами 7.62x39 мм (УС гж)"
ITEM.description = ""
ITEM.longdesc = "Утяжеленный патрон 7.62x39 мм УС гж (Индекс ГАУ - 57-Н-231У) с дозвуковой пулей массой 20 грамм с заостренным термоупрочненным стальным сердечником. с биметаллической оболочкой. в биметаллической гильзе с уменьшенным зарядом. Патрон УС (Уменьшенной Скорости) был разработан в 1950-х годах для использования в сочетании с глушителем ПБС-1. обеспечивая снижение шума оружия 7.62x39 мм. Пуля обладает хорошей пробивной способностью против брони базового уровня защиты. однако имеет высокую вероятность отскока от различных поверхностей."
ITEM.model = "models/lostsignalproject/items/misc/small_wood_box.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 400 -- Количество патриков в коробке.
ITEM.price = 18000 --Цена.
ITEM.ammo = "7.62x39submm" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/misc/small_wood_box.mdl"

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Штурмовой патрон калибра 7.62x39 мм", Color(64, 224, 208))
    ix.util.PropertyDesc(tooltip, "Содержит порох", Color(64, 224, 208))
    ix.util.PropertyDesc(tooltip, "Содержит гильзу", Color(64, 224, 208))
end

--Эту функцию не трогай. Ежжи.
ITEM.functions.use = {
    name = "Зарядить магазин",
    icon = "icon16/stalker/load.png",
    OnRun = function(item)
    local rounds = item:GetData("rounds", item.ammoAmount)

    ix.util.PlayerPerformBlackScreenAction(item.player, "Заряжаем магазин...", 8, function(player) 
      ix.chat.Send(player, "me", "заряжает магазины патронами 5.45x39 мм.")
    end)
      item.player:GiveAmmo(rounds, item.ammo)
      item.player:EmitSound(item.useSound, 110)
    return true
  end,
}