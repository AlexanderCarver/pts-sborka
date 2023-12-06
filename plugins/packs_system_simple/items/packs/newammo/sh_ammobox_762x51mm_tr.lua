ITEM.name = "Патроны 7.62x51 мм (M62 Tracer)"
ITEM.description = ""
ITEM.longdesc = "Патрон 7.62x51 мм НАТО M62 с трассирующей пулей массой 24 грамм с сердечником из свинцово-сурьмянистого сплава в биметаллической оболочке, в латунной гильзе. Предназначен для целеуказания и корректировки огня в бою (цвет трассера: Зеленый). Патрон был разработан для обеспечения возможности отслеживания стрельбы автоматического оружия 7.62x51 мм, используемого в вооруженных силах Соединенных Штатов, а также существенной пробивной способности против брони базового и среднего уровня защиты. Из-за своей конструкции, пуля имеет высокую вероятность отскока от различных поверхностей."
ITEM.model = "models/lostsignalproject/items/ammo/762x51.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 20 -- Количество патриков в коробке.
ITEM.price = 1080 --Цена.
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