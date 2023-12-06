ITEM.name = "Патроны 7.92x33 мм"
ITEM.description = ""
ITEM.longdesc = "Германский 7,9-мм промежуточный патрон времён Второй мировой войны."
ITEM.model = "models/lostsignalproject/items/misc/damaged_ammo.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 30 -- Количество патриков в коробке.
ITEM.price = 1120 --Цена.
ITEM.ammo = "7.92x33mm" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/misc/damaged_ammo.mdl"

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Винтовочный патрон калибра 7.92x33 мм", Color(64, 224, 208))
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
      ix.chat.Send(player, "me", "заряжает магазины патронами 7.92x57 мм")
    end)
      item.player:GiveAmmo(rounds, item.ammo)
      item.player:EmitSound(item.useSound, 110)
    return true
  end,
}