ITEM.name = "Пиво Балтика №9"
ITEM.description = "Алюминевая банка пива, которая расслабляет после тяжелого дня."
ITEM.longdesc = "Пиво Балтика - это настоящая классика 90-ых. Бежевая банка - это выбор ценителей крепкого вкуса и повышенного градуса алкоголя, с терпким пшеничный вкусом и ароматом солода, что всегда согреет душу."
ITEM.model = "models/banka2.mdl"
ITEM.skin = 1

ITEM.width = 1
ITEM.height = 1

ITEM.price = 400
ITEM.destroy_item = true

ITEM.thirst_amount = -6
ITEM.hunger_amount = 0
ITEM.drunk_amount = 8
ITEM.staminaAmount = 10

ITEM.quantity = 2

ITEM.weight = 0.180
ITEM.flatweight = 0.034

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc2(tooltip, "Можно выпить", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/hunger.png"))
    ix.util.PropertyDesc2(tooltip, "Алкоголь", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/thermprot.png"))
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
			ix.chat.Send(player, "me", "достает бежевую банку пива 'Балтика' и делает несколько глотков.")
			item.player:GetCharacter():SatisfyAddictions("LightAlcohol")
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