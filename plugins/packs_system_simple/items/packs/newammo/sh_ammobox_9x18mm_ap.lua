ITEM.name = "Патроны 9x18 мм (ПБМ гж)"
ITEM.description = ""
ITEM.longdesc = "Патрон 9x18 мм ПМ ПБМ гж (Индекс ГРАУ - 7Н25) с бронебойной пулей массой 7 грамм с сердечником из закаленной углеродистой стали, в биметаллической гильзе. Патрон был разработан в 1990-х годах для увеличения пробивной способности оружия 9x18мм ПМ, и, благодаря своей высокой начальной скорости, он способен пробивать броню базового и среднего уровня защиты на коротких дистанциях ценой увеличенной отдачи."
ITEM.model = "models/lostsignalproject/items/ammo/9x18_p.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 40 -- Количество патриков в коробке.
ITEM.price = 1680 --Цена.
ITEM.ammo = "9x18apmm" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/ammo/9x18_p.mdl" --Моделька.

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Пистолетный патрон калибра 9x18 мм", Color(64, 224, 208))
    ix.util.PropertyDesc(tooltip, "Содержит порох", Color(64, 224, 208))
    ix.util.PropertyDesc(tooltip, "Пистолетная гильза", Color(64, 224, 208))
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