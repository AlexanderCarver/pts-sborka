ITEM.name = "Патроны 7.62x54 мм (СНБ гж)"
ITEM.description = ""
ITEM.longdesc = "Патрон 7.62x54 мм R СНБ гж (Индекс ГРАУ - 7Н14) с бронебойной пулей массой 25 грамм с заостренным термоупрочненным стальным сердечником над свинцовым поддоном, в биметаллической оболочке, в биметаллической гильзе. Патрон СНБ (Снайперский с Бронебойной пулей) был разработан в середине 1990-х годов как модернизация патрона 7.62x54 ммR ПС гж с целью улучшения его пробивной способности при стрельбе из снайперских винтовок. Обладает высокой бронепробиваемостью даже против брони 5-6 класса защиты и существенным останавливающим действием."
ITEM.model = "models/lostsignalproject/items/ammo/762x54_ap.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 20 -- Количество патриков в коробке.
ITEM.price = 1440 --Цена.
ITEM.ammo = "7.62x54apmm" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/ammo/762x54_ap.mdl"

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Винтовочный патрон калибра 7.62x54 мм", Color(64, 224, 208))
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