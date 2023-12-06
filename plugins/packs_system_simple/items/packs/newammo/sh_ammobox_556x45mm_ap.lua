ITEM.name = "Патроны 5.56x45 мм (M855)"
ITEM.description = ""
ITEM.longdesc = "Патрон 5.56x45 мм НАТО M855 с пулей массой 12 грамм со стальным наконечником-пенетратором над свинцовым сердечником. с медной оболочкой. в латунной гильзе. Патрон был разработан в 1980-х годах как эквивалент патрона FN SS109 для вооружения 5.56x45 мм. используемого в армии США. Благодаря своей конструкции. пуля в этом патроне обладает хорошей пробивной и поражающей способностью против брони базового уровня защиты. однако имеет высокую вероятность отскока от различных поверхностей."
ITEM.model = "models/lostsignalproject/items/ammo/556x45_ap.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 30 -- Количество патриков в коробке.
ITEM.price = 1800 --Цена.
ITEM.ammo = "5.56x45apmm" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/ammo/556x45_ap.mdl"

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Штурмовой патрон калибра 5.56x45 мм NATO", Color(64, 224, 208))
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