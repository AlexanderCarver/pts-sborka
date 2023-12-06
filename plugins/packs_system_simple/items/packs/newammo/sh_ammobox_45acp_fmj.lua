ITEM.name = "Патроны .45 ACP (FMJ)"
ITEM.description = ""
ITEM.longdesc = "Патрон .45 ACP (11.43x23мм) Match FMJ (Cartridge, Caliber .45, Ball, Match, M1911) с пулей массой 21 грамм со свинцовым сердечником, в медной оболочке, в латунной гильзе. Патрон изготовлен с повышенной точностью, чтобы удовлетворить потребности современного оружия .45 ACP, используемого вооруженными силами США. Обладает значительной убойностью и пробивной способностью против брони базового и среднего уровня защиты."
ITEM.model = "models/lostsignalproject/items/ammo/45cal.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 40 -- Количество патриков в коробке.
ITEM.price = 1680 --Цена.
ITEM.ammo = "45hpacp" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/ammo/45cal.mdl" --Моделька.

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Пистолетный патрон калибра .45 ACP", Color(64, 224, 208))
    ix.util.PropertyDesc(tooltip, "Содержит порох", Color(64, 224, 208))
    ix.util.PropertyDesc(tooltip, "Содержит пистолетную гильзу", Color(64, 224, 208))
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