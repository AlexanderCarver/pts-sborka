ITEM.name = "Цинк с патронами 7.62x51 мм (M80)"
ITEM.description = ""
ITEM.longdesc = "Патрон 7.62x51 мм НАТО M80 с пулей массой 21 грамм с сердечником из свинцово-сурьмянистого сплава в биметаллической оболочке, в латунной гильзе. Этот патрон был принят в вооруженных силах США в качестве замены патрона 7.62x51 мм НАТО M59 после войны во Вьетнаме в качестве стандартного боеприпаса. Обеспечивает значительное останавливающее воздействие и хорошую пробивную способность против брони базового и среднего уровня защиты. Однако, из-за своей конструкции, пуля имеет высокую вероятность отскока от различных поверхностей."
ITEM.model = "models/lostsignalproject/items/misc/small_case.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 400 -- Количество патриков в коробке.
ITEM.price = 28080 --Цена.
ITEM.ammo = "7.62x51apmm" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/misc/small_case.mdl"

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