ITEM.name = "Патроны 12.7x99 мм «Blank Cartridge»"
ITEM.description = ""
ITEM.longdesc = "Принят на вооружение 25 мая 1935 года. Дульце гильзы закрывалось картонной прокладкой, фиксировавшейся каннелюрой и завальцовкой кромки дульца. Прокладка покрывалась красным лаком для герметизации."
ITEM.model = "models/lostsignalproject/items/ammo/127x55.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 10 -- Количество патриков в коробке.
ITEM.price = 1000 --Цена.
ITEM.ammo = "12.7x99blkmm" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/ammo/127x55.mdl" --Моделька.

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Винтовочный патрон калибра 12.7x99 мм", Color(64, 224, 208))
    ix.util.PropertyDesc(tooltip, "Содержит порох", Color(64, 224, 208))
    ix.util.PropertyDesc(tooltip, "Содержит винтовочную гильзу", Color(64, 224, 208))
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