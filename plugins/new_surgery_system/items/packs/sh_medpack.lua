ITEM.name = "Припасы для хирургии"
ITEM.description = "Набор инструментов и материалов для хирургической обработки ран."
ITEM.model = "models/items/healthkit.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.category = "Медицинское оборудование"
ITEM.price = 50
ITEM.isStackable = true
ITEM.quantity = 1 -- Количество использований хирургического набора, которое будет восстановлено
ITEM.functions.Use = {
    name = "Использовать",
    icon = "icon16/box.png",
    OnRun = function(item)
        local client = item.player
        local inventory = client:GetCharacter():GetInventory()

        -- Поиск хирургического набора в инвентаре игрока
        local hasSurgicalKit = false
        for _, v in ipairs(inventory:GetItems()) do
            if v.uniqueID == "surgical_kit" then
                hasSurgicalKit = true
                break
            end
        end

        if hasSurgicalKit then
            local surgicalKit = inventory:GetFirstItemOfClass("surgery_pack")
            local quantity = surgicalKit:GetData("quantity", surgicalKit.quantity)
            local maxQuantity = surgicalKit.quantity -- Максимальное количество использований хирургического набора

            -- Увеличение количества использований хирургического набора
            if quantity < maxQuantity then
                local newQuantity = math.min(maxQuantity, quantity + item.quantity)
                surgicalKit:SetData("quantity", newQuantity)
                client:EmitSound("items/medshot4.wav")

                -- Удаление предмета "Припасы для хирургии"
                if item:GetData("quantity", item.quantity) <= 1 then
                    item:Remove()
                else
                    item:SetData("quantity", item:GetData("quantity", item.quantity) - 1)
                end
            else
                client:Notify("Хирургический набор уже в полном порядке.")
            end
        else
            client:Notify("У вас нет хирургического набора.")
        end

        return false
    end,
    OnCanRun = function(item)
        return true
    end,
}