ITEM.name = "Патроны 5.45x39 мм (БС)"
ITEM.description = ""
ITEM.longdesc = "Патрон 5.45х39 мм БС гс (Индекс ГРАУ — 7Н24) со специальной бронебойной пулей БС массой 10 грамм с заостренным сердечником из карбида вольфрама. с биметаллической оболочкой. в стальной гильзе. Пуля БС (Бронебойный Сердечник) была разработана в ЦНИИТочМаш в 1998 году для значительного увеличения пробивной способности российского оружия 5.45х39 мм. что привело к выдающимся результатам против некоторых специализированных моделей 5-6 класса защиты. несмотря на относительно низкую начальную скорость пули по сравнению с другими патронами. Однако. из-за своей конструкции. она имеет высокую вероятность отскока от различных поверхностей."
ITEM.model = "models/lostsignalproject/items/ammo/545x39_ap.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 30 -- Количество патриков в коробке.
ITEM.price = 1680 --Цена.
ITEM.ammo = "5.45x39apmm" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/ammo/545x39_ap.mdl" --Моделька.

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