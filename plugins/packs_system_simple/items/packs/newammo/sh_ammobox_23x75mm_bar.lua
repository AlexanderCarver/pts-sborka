ITEM.name = "Патроны 23x75 «Баррикада»"
ITEM.description = ""
ITEM.longdesc = "Патрон 23x75 мм R «Баррикада» с цельностальной остроконечной пулей, способной принудительно останавливать автомобили, повреждая их двигатель. Дальность применения до 100 метров."
ITEM.model = "models/lostsignalproject/items/ammo/12x70.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 10 -- Количество патриков в коробке.
ITEM.price = 640 --Цена.
ITEM.ammo = "23x75barmm" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/ammo/12x70.mdl" --Моделька.

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