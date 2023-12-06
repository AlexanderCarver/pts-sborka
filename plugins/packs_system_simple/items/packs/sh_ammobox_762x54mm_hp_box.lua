ITEM.name = "Цинк с патронами 7.62x54 мм (ЛПС гж)"
ITEM.description = ""
ITEM.longdesc = "Патрон 7.62х54ммR ЛПС гж (Индекс ГРАУ - 57-Н-323С) с пулей массой 24 грамм со стальным сердечником, в биметаллической оболочке, в биметаллической гильзе. Патрон ЛПС (Легкая Пуля со Стальным сердечником) был принят на вооружение в 1953 году для советского оружия 7.62x54 ммR, и за эти годы претерпел множество изменений в материалах изготовления. Благодаря стальному сердечнику, пуля обладает хорошей бронепробиваемостью против базового и среднего уровня защиты и значительным останавливающим воздействием, однако она имеет высокую вероятность отскока от различных поверхностей."
ITEM.model = "models/lostsignalproject/items/misc/small_case.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 400 -- Количество патриков в коробке.
ITEM.price = 22680 --Цена.
ITEM.ammo = "7.62x54hpmm" --Сами патрики.
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