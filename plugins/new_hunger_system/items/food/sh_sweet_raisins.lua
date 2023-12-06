
ITEM.name = "Изюм"
ITEM.description = "Маленький пакет, содержащий сушеные виноградные ягоды."
ITEM.longdesc = "Этот пакетик содержит сушеные виноградные ягоды - изюм. Давно известный десерт, который производится путем высушивания винограда на солнце или в духовке. Он обладает приятным сладковатым вкусом и является богатым источником энергии и питательных веществ. Изюм можно употреблять как самостоятельное лакомство, так и добавлять в различные блюда."
ITEM.model = "models/lostsignalproject/items/consumable/raisins.mdl"

ITEM.width = 1
ITEM.height = 1

ITEM.price = 170
ITEM.destroy_item = true

ITEM.thirst_amount = -2
ITEM.hunger_amount = 5
ITEM.drunk_amount = 0
ITEM.staminaAmount = 0

ITEM.quantity = 4

ITEM.weight = 0.012
ITEM.flatweight = 0.004

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
			ix.chat.Send(player, "me", "достаёт пакет с изюмом и употребляет горсть сушёного винограда.")
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