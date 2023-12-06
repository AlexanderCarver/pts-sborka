ITEM.name = "Патроны .338 (AP)"
ITEM.description = ""
ITEM.longdesc = "Патрон .338 Lapua Magnum (8.6x70мм) AP с двухэлементной пулей массой 49 грамм с наконечником из карбида вольфрама и поддоном, в латунной гильзе. Патрон был разработан для увеличения антиматериальных возможностей винтовок .338 Lapua Magnum, и способен пробивать легкобронированный транспорт, проявляя превосходные результаты против самых современных средств индивидуалньой защиты 5-6 класса. Пуля также обладает разрушительным останавливающим и травмирующим воздействием на цель после попадания. Однако, из-за своей конструкции, она имеет высокую вероятность отскока от различных поверхностей."
ITEM.model = "models/kek1ch/ammo_86x70_fmj.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 15 -- Количество патриков в коробке.
ITEM.price = 1230 --Цена.
ITEM.ammo = "338aplm" --Сами патрики.
ITEM.model = "models/kek1ch/ammo_86x70_fmj.mdl" --Моделька.

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Винтовочный патрон калибра .338 Lapua Magnum", Color(64, 224, 208))
    ix.util.PropertyDesc(tooltip, "Содержит порох", Color(64, 224, 208))
    ix.util.PropertyDesc(tooltip, "Содержит винтовочную гильзу", Color(64, 224, 208))
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