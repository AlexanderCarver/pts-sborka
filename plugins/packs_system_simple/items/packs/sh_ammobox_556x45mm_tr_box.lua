ITEM.name = "Цинк 5.56x45 мм (M856)"
ITEM.description = ""
ITEM.longdesc = "Трассирующий патрон M856 используется в оружии M16A2 /3 / 4, серии M4 и M249 (среди прочего оружия НАТО калибра 5,56 мм). Этот патрон рассчитан на дальность стрельбы до 900 метров и имеет красный наконечник (оранжевый при соотношении 4 к 1 с M249)."
ITEM.model = "models/lostsignalproject/items/misc/small_wood_box.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 600 -- Количество патриков в коробке.
ITEM.price = 22860 --Цена.
ITEM.ammo = "5.56x45trr" --Сами патрики.
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