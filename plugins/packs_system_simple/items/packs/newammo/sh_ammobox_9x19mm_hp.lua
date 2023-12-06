ITEM.name = "Птроны 9х19 мм (QuakeMaker)"
ITEM.description = ""
ITEM.longdesc = "Патрон 9x19мм Парабеллум QuakeMaker с экспансивной свинцовой пулей массой 8 грамм в легкой стальной гильзе с закраиной из анодированного в красный алюминия. Предназначен для защиты дома и тренировочной стрельбы. Благодаря своей конструкции, патрон обеспечивает выдающееся останавливающее действие, а также вызывает серьезное травмирующее воздействие на цель после попадания. Имеет значительно более низкую начальную скорость по сравнению с другими патронами того же калибра."
ITEM.model = "models/lostsignalproject/items/ammo/9x19.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 40 -- Количество патриков в коробке.
ITEM.price = 1600 --Цена.
ITEM.ammo = "9x19hpmm" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/ammo/9x19.mdl" --Моделька.

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