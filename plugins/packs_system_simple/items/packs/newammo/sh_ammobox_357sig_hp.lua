ITEM.name = "Патроны .357 (HP)"
ITEM.description = ""
ITEM.longdesc = "Американский револьверный патрон .357 Magnum большой мощности, созданный компанией Smith & Wesson."
ITEM.model = "models/lostsignalproject/items/ammo/357.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 40 -- Количество патриков в коробке.
ITEM.price = 1760 --Цена.
ITEM.ammo = "357hpsig" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/ammo/357.mdl" --Моделька.

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Револьверный патрон калибра .357 SIG", Color(64, 224, 208))
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