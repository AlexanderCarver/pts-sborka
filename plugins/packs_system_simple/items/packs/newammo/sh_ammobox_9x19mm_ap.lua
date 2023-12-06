ITEM.name = "Патроны 9x19 мм (ПБМ гж)"
ITEM.description = ""
ITEM.longdesc = "Патрон 9x19 мм Парабеллум ПБП гж (Индекс ГРАУ - 7Н31) с бронебойной пулей массой 8 грамма с сердечником из закаленной углеродистой стали, в плакированной томпаком стальной оболочке, в биметаллической гильзе. Конструкция пули основана на опыте с различными бронебойными пистолетными патронами в конце 1990-х годов, направленных на нейтрализацию противника, оснащенного броней базового и среднего уровня защиты, а также способности пробивать легкие укрытия и автомобили, обладая при этом высокой начальной скоростью."
ITEM.model = "models/lostsignalproject/items/ammo/9x19_p.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 40 -- Количество патриков в коробке.
ITEM.price = 1800 --Цена.
ITEM.ammo = "9x19apmm" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/ammo/9x19_p.mdl" --Моделька.

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Пистолетный патрон калибра 9x19 мм", Color(64, 224, 208))
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