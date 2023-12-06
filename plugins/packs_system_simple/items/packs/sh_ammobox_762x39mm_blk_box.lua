ITEM.name = "Цинк с патронами 7.62x39 мм (ПХС-19)"
ITEM.description = ""
ITEM.longdesc = "В 70-х годах XX века вместе с 7.62/30-мм стрелково-гранатомётным комплексом «Тишина» под индексом ГРАУ 7Щ2 был принят на вооружение специальный холостой патрон. созданный конструктором ЦНИИТОЧМАШ М.И. Лысенко на основе гильзы патрона обр. 1943 г. Патрон предназначен для метания гранат из 30-мм бесшумного подствольного гранатомета."
ITEM.model = "models/lostsignalproject/items/misc/small_wood_box.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 400 -- Количество патриков в коробке.
ITEM.price = 9360 --Цена.
ITEM.ammo = "7.62x39blkmm" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/misc/small_wood_box.mdl"

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