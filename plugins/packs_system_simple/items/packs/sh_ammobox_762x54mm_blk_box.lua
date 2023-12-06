ITEM.name = "Цинк с патронами 7.62x54 мм (57-Х-340)"
ITEM.description = ""
ITEM.longdesc = "Холостой патрон предназначен для имитации звукового эффекта стрельбы из всех видов штатного оружия под патроны 7.62x54 мм. Патрон используется с дульной втулкой. которая обеспечивает давление пороховых газов. необходимое для работы автоматики оружия."
ITEM.model = "models/lostsignalproject/items/misc/small_case.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 400 -- Количество патриков в коробке.
ITEM.price = 9720 --Цена.
ITEM.ammo = "7.62x54blkmm" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/misc/small_case.mdl"

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