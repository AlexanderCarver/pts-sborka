ITEM.name = "Патроны 7.62x51 мм (M993)"
ITEM.description = ""
ITEM.longdesc = "Патрон 7.62x51 мм НАТО M993 с бронебойной пулей массой 24 грамма с наконечником из карбида вольфрама на алюминиевом сердечнике, в медной оболочке, в латунной гильзе. Патрон был разработан в 1990-х годах, чтобы предоставить личному составу вооруженных сил США возможность пробивать легкие укрытия и легкобронированный транспорт, а также обеспечивать выдающиеся результаты против самых современных специализированных средств защиты 5-6 класса."
ITEM.model = "models/lostsignalproject/items/ammo/762x51.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 20 -- Количество патриков в коробке.
ITEM.price = 1480 --Цена.
ITEM.ammo = "7.62x51matchmm" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/ammo/762x51.mdl"

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Винтовочный патрон калибра 7.62x51 мм NATO", Color(64, 224, 208))
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