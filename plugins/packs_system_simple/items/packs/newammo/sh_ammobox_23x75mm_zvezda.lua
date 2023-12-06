ITEM.name = "Патроны 23x75 «Звезда»"
ITEM.description = ""
ITEM.longdesc = "Светозвуковой патрон 23х75 мм R «Звезда», предназначенный для психологического воздействия на противника."
ITEM.model = "models/lostsignalproject/items/ammo/12x76_jhp.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 10 -- Количество патриков в коробке.
ITEM.price = 1500 --Цена.
ITEM.ammo = "23x75zvezmm" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/ammo/12x76_jhp.mdl" --Моделька.

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Ружейный патрон калибра 23x75 мм", Color(64, 224, 208))
    ix.util.PropertyDesc(tooltip, "Содержит порох", Color(64, 224, 208))
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