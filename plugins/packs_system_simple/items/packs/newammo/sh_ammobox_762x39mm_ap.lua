ITEM.name = "Патроны 7.62x39 мм (БП гж)"
ITEM.description = ""
ITEM.longdesc = "Патрон 7.62x39 мм БП гж (Индекс ГРАУ - 7Н23) с бронебойной пулей массой 17 грамм с сердечником из закаленной углеродистой стали. с плакированной томпаком биметаллической оболочкой. в биметаллической гильзе. Пуля БП была разработана в 1990-х годах на основе 7.62x39 мм ПС гж для улучшения ее конструкции и пробивной способности. Был выбран более длинный и узкий армированный стальной сердечник. позволяющий пробивать броню базового и среднего уровня защиты. обеспечивая значительное останавливающее воздействие. Однако. из-за своей конструкции. пуля имеет высокую вероятность отскока от различных поверхностей."
ITEM.model = "models/lostsignalproject/items/misc/small_wood_box.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 20 -- Количество патриков в коробке.
ITEM.price = 1340 --Цена.
ITEM.ammo = "7.62x39apmm" --Сами патрики.
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