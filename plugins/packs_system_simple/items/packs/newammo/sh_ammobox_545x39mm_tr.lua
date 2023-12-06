ITEM.name = "Патроны 5.45x39 мм (Т гс)"
ITEM.description = ""
ITEM.longdesc = "Патрон 5.45х39 мм Т гс (Индекс ГРАУ - 7Т3) с трассирующей пулей массой 13 грамм со свинцовым сердечником. в биметаллической оболочке. в стальной гильзе. Предназначен для целеуказания и корректировки огня в бою (цвет трассера: Красный). Патрон Т (Трассирующий) был представлен в 1974 году вместе с патроном ПС гс (Индекс ГРАУ - 7Н6) для обеспечения возможности отслеживания стрельбы для вооружения 5.45х39 мм. а также хорошей пробивной и поражающей способности против брони базового уровня защиты. Однако. из-за своей конструкции. пуля имеет высокую вероятность отскока от различных поверхностей."
ITEM.model = "models/lostsignalproject/items/ammo/545x39.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 30 -- Количество патриков в коробке.
ITEM.price = 600 --Цена.
ITEM.ammo = "5.45x39trr" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/ammo/545x39.mdl"

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Штурмовой патрон калибра 5.45x39 мм", Color(64, 224, 208))
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