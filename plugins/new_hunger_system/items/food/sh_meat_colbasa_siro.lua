ITEM.name = "Колбаса сырокопченая"
ITEM.description = "Мясной продукт, готовый к употреблению."
ITEM.longdesc = "Колбаса, которая прошла процесс сырокопчения, то есть была выдержана в дыму из сухих пород древесины, что придает ей характерный аромат и вкус. Колбаса может быть приготовлена из различных видов мяса, например, свинины, говядины, индейки или курицы, и содержать различные специи и пряности."
ITEM.model = "models/lostsignalproject/items/consumable/sausage.mdl"

ITEM.width = 1
ITEM.height = 1

ITEM.price = 320
ITEM.destroy_item = true

ITEM.thirst_amount = -5
ITEM.hunger_amount = 10
ITEM.drunk_amount = 0
ITEM.staminaAmount = 5

ITEM.quantity = 4

ITEM.weight = 0.120
ITEM.flatweight = 0

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc2(tooltip, "Съедобное", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/hunger.png"))
end

ITEM.functions.use = {
    name = "Употребить",
    icon = "icon16/stalker/eat.png",
    OnRun = function(item)
        local quantity = item:GetData("quantity", item.quantity or 1)
        
        quantity = quantity - 1
        item:SetData("quantity", quantity)
        
        local client = item.player
        local mul = COOKLEVEL[item:GetData("cooklevel", 0)][1]
        
        if mul < 1 then
            mul = 1
        end
        
        if (item.thirst_amount ~= 0) then
            client:AddThirstVar(item.thirst_amount * mul)
        end
        
        if (item.hunger_amount ~= 0) then
            client:AddHungerVar(item.hunger_amount * mul)
        end
        
        if (item.drunk_amount ~= 0) then
            client:AddDrunkVar(item.drunk_amount)
        end
        
        if (math.random(1, 5) == 3) then
            client:SetHealth(math.Clamp(client:Health() + math.random(1, 10), 0, client:GetMaxHealth()))
        end
        
        client:EmitSound("stalkersound/inv_flask.mp3", 50, 75)
        
        ix.util.PlayerPerformBlackScreenAction(item.player, "Употребление...", 4, function(player) 
			ix.chat.Send(player, "me", "достаёт сырокопчённую колбасу и употребляет часть продукта.")
		end)

        if (quantity <= 0) then
            if (item.empty_item and ix.item.Get(item.empty_item)) then
                if (!client:GetCharacter():GetInventory():Add(item.empty_item)) then
                    ix.item.Spawn(item.empty_item, client)
                    return true
                end
            end
            
            if (item.destroy_item) then
                return true
            end
        end

        return false
    end,
    
    OnCanRun = function(item)
        if (item:GetData("quantity", item.quantity or 1) <= 0) then
            return false
        end
        
        return true
    end
}