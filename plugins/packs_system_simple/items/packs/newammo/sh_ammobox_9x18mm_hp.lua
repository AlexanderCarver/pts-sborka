ITEM.name = "Патроны 9x18 мм (СП8 гж)"
ITEM.description = ""
ITEM.longdesc = "Патрон 9х18 мм ПМ СП8 гж с хрупкой экспансивной пулей массой 9 грамм с полимерным сердечником в головной части и свинцовым сердечником в хвостовой части, с латунной полуоболочкой, в биметаллической гильзе с уменьшенным зарядом. Разработан в середине 80-х годов в ЦНИИТочМаш для создания патрона с низкой бронепробиваемостью, позволяющего свести к минимуму разрушение и пробивание объектов с низкой структурной прочностью (например во время контртеррористических операций на самолетах) и при этом обеспечивающего значительное останавливающее и травмирующее воздействие при попадании."
ITEM.model = "models/lostsignalproject/items/ammo/9x18_p.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 40 -- Количество патриков в коробке.
ITEM.price = 1520 --Цена.
ITEM.ammo = "9x18hpmm" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/ammo/9x18_p.mdl" --Моделька.

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Пистолетный патрон калибра 9x18 мм", Color(64, 224, 208))
    ix.util.PropertyDesc(tooltip, "Содержит порох", Color(64, 224, 208))
    ix.util.PropertyDesc(tooltip, "Пистолетная гильза", Color(64, 224, 208))
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