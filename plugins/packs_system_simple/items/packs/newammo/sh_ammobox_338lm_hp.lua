ITEM.name = "Патроны .338 (TAC-X)"
ITEM.description = ""
ITEM.longdesc = "Гражданский патрон .338 Lapua Magnum (8.6x70мм) TAC-X с экспансивной медной пулей массой 49 грамм, в латунной гильзе. Пуля обеспечивает хорошую передачу энергии на больших дистанциях и предназначена для охоты на крупную дичь, так как обладает превосходным останавливающим действием для своего и способна вызывать критическое травмирующее воздействие на цель после удара. Однако, несмотря на высокую энергию ua Magnum и конструкцию пули, она не обладает бронебойными свойствами и имеет высокую вероятность отскока от различных поверхностей."
ITEM.model = "models/kek1ch/ammo_86x70_fmj.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 15 -- Количество патриков в коробке.
ITEM.price = 1170 --Цена.
ITEM.ammo = "338hplm" --Сами патрики.
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