ITEM.name = "Патроны 12x70 (Флешетта)"
ITEM.description = ""
ITEM.longdesc = "Патрон, снаряженный заточенными флешеттами 12/70, для ружей 12 калибра. Далеко не самый эффективный патрон, но поверьте - вы бы точно не хотели оказаться по другую сторону дульного среза."
ITEM.model = "models/lostsignalproject/items/ammo/23mm.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 25 -- Количество патриков в коробке.
ITEM.price = 1440 --Цена.
ITEM.ammo = "12x70flechmm" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/ammo/23mm.mdl" --Моделька.

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Ружейный патрон 12-го калибра", Color(64, 224, 208))
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