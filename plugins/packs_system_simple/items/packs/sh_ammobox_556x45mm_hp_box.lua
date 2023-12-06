ITEM.name = "Цинк с патронами 5.56x45 мм (HP)"
ITEM.description = ""
ITEM.longdesc = "Патрон .223 Remington (5.56x45 мм) с экспансивной пулей массой 13 грамм со свинцовым сердечником. с биметаллической оболочкой. в стальной гильзе. Предназначен для охоты. домашней обороны и стрельбы по мишеням. Несмотря на то. что пуля не обладает полной энергией промежуточного патрона. она имеет значительную поражающую способность. а также оказывает существенное травмирующее воздействие на цель после удара. Не обладает пробивной способностью даже против брони базового уровня защиты."
ITEM.model = "models/lostsignalproject/items/misc/small_wood_box.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 600 -- Количество патриков в коробке.
ITEM.price = 25920 --Цена.
ITEM.ammo = "5.56x45hpmm" --Сами патрики.
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