ITEM.name = "Патроны 9x18 мм (10ТК)"
ITEM.description = ""
ITEM.longdesc = "Данный патрон имеет калибр 10ТК т.е. его диаметр 10мм что является увеличенным диаметром патронника у СХП, длина патрона 21мм, вальцовка звездой - при выстреле немного раскрывается. (состоит из - гильза, капсуль и пороховой заряд)."
ITEM.model = "models/lostsignalproject/items/ammo/9x18_p.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 40 -- Количество патриков в коробке.
ITEM.price = 640 --Цена.
ITEM.ammo = "9x18blkmm" --Сами патрики.
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