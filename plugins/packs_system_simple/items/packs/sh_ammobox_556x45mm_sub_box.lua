ITEM.name = "Цинк с патронами 5.56x45 мм (MK 255 Mod 0)"
ITEM.description = ""
ITEM.longdesc = "Патрон 5.56x45 мм НАТО MK 255 Mod 0 (RRLP) с пулей массой 12 грамма с медно-полимерным композитным сердечником. с медной рубашкой. в латунной гильзе. Патрон был разработан под названием RRLP (Reduced Ricochet Limited Penetration - Уменьшенной Рикошетируемости и Ограниченной Пробиваемости). чтобы существенно снизить сопутствующий ущерб от рикошетов и чрезмерного пробивания во время тренировок и операций на близких дистанциях. а также обеспечить значительную поражающую способность."
ITEM.model = "models/lostsignalproject/items/misc/small_wood_box.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 600 -- Количество патриков в коробке.
ITEM.price = 28080 --Цена.
ITEM.ammo = "5.56x45submm" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/misc/small_wood_box.mdl"

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