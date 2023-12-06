ITEM.name = "Патроны 7.62x39 мм (HP)"
ITEM.description = ""
ITEM.longdesc = "Патрон 7.62x39 мм с экспансивной пулей (Hollow Point) массой 17 грамм со свинцовым сердечником. с биметаллической полуоболочкой. в стальной гильзе. Предназначен для охоты. обороны дома и стрельбы. Пуля в этом патроне обладает отличным расширением и передачей энергии при ударе. что придает ей исключительное останавливающее и травмирующее воздействие на цель после попадания. что делает патрон хорошим выбором для охоты."
ITEM.model = "models/lostsignalproject/items/ammo/762x39.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 20 -- Количество патриков в коробке.
ITEM.price = 980 --Цена.
ITEM.ammo = "7.62x39hpmm" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/ammo/762x39.mdl"

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Штурмовой патрон калибра 7.62x39 мм", Color(64, 224, 208))
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