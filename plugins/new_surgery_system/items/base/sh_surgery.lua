ITEM.name = "surgery"
ITEM.description = "Helps your body survive in the zone - in one way or another."
ITEM.longdesc = "Longer description here."
ITEM.category = "Хирургия"
ITEM.width = 1
ITEM.height = 1
ITEM.healAmount = 5
ITEM.healSeconds = 3
ITEM.quatity = 1
--ITEM.sound = "takepills1.wav"
ITEM.weight = 0.085
ITEM.flatweight = 0.130

ITEM.medAttr = 0

-- Через сколько секунд, полностью вылечится персонаж от инфекции.
ITEM.healInfectationSeconds = 0

-- Если true то предмет будет воскрешающим.
ITEM.healRevive = false

-- Сколько секунд будет занимать реанимация
ITEM.healReviveSeconds = 5

if CLIENT then
	function ITEM:GetDescription()
		local medical = LocalPlayer():GetCharacter():GetAttribute("medical", 0)
		local heal_hp = math.Round(self.healAmount / self.healSeconds + medical / 2, 1)
		
		if self.medAttr > 0 then
			return L(self.description .. "\n Вам требуется более высокие знания медицины для использования.")
		end
	end
end

local function healPlayer(client, target, amount, seconds, attribute)
	if (client:Alive() and target:Alive()) then
		hook.Run("OnPlayerHeal", client, target, amount, seconds)

		local id = "ixHeal_"..FrameTime()
		timer.Create(id, 1, seconds, function()
			if (!IsValid(target) or !target:Alive()) then
				timer.Remove(id)	
			end

			target:SetHealth(math.Clamp(target:Health() + (amount/seconds) + attribute/2, 0, target:GetMaxHealth()))
		end)
		
		client:GetCharacter():SetAttrib("medical", attribute + 0.08)
	end
end

ITEM:Hook("drop", function(item)
	local owner = item.GetOwner and item:GetOwner()
	
	if (IsValid(owner) and owner.beingUsed == item) then
		owner = nil
		return
	end
end)

function ITEM:CanTransfer()
	local owner = self.GetOwner and self:GetOwner()
	
	if (IsValid(owner) and owner.beingUsed == self) then
		owner = nil
		return false
	end
end

ITEM.functions.use = {
	name = "Обработать свои раны",
	icon = "icon16/pill.png",
	sound = "stalkersound/inv_syringe.mp3",
	OnRun = function(item)
	local quantity = item:GetData("quantity", item.quantity)
	local client = item.player
		if quantity == nil then
			quantity = item.quantity
		end
	
		if (IsValid(client)) then
			local medical = client:GetCharacter():GetAttribute("medical", 0)
	
			if medical >= item.medAttr then
				client.beingUsed = item
	
				ix.util.PlayerPerformBlackScreenAction(item.player, "Обработка ран...", 10, function(player)
					if (not IsValid(client) or not client:Alive()) then
						client.beingUsed = nil
						return
					end
	
					local chance = math.random(1, 2)
					if chance == 1 then
						ix.Wounds:SetBleeding(client)
						client:Notify("Вы вызвали кровотечение во время полевой хирургии.")
						healPlayer(client, client, item.healAmount, item.healSeconds, medical)
						if item.healInfectationSeconds > 0 and client.HealInfectation then
							client:HealInfectation(item.healInfectationSeconds)
						end
					else
						healPlayer(client, client, item.healAmount, item.healSeconds, medical)
						if item.healInfectationSeconds > 0 and client.HealInfectation then
							client:HealInfectation(item.healInfectationSeconds)
						end
					end
	
					client.beingUsed = nil
	
					if quantity > 1 then
						item:SetData("quantity", quantity - 1)
					else
						item:Remove()
					end
				end)
	
				local character = client:GetCharacter()
				local name = character:GetName()
	
				if quantity > 1 then
					ix.chat.Send(client, "me", " обрабатывает свои раны, используя хирургический набор. Осталось "..(quantity-1).." использований.")
				else
					ix.chat.Send(client, "me", " обрабатывает свои раны, используя последний хирургический набор.")
				end
			else
				client:Notify("Недостаточно медицинских знаний.")
			end
		end
	
		return false
	end,
	OnCanRun = function(item)
		local cur_item = item.player.beingUsed
	
		if cur_item and cur_item == item then
			cur_item = nil
			return false
		end
	
		return true
	end
}

ITEM.functions.use_on = {
	name = "Обработать чужие раны",
	icon = "icon16/pill.png",
	sound = "stalkersound/inv_syringe.mp3",
	OnRun = function(item)
	local client = item.player
		local data = {}
		data.start = client:GetShootPos()
		data.endpos = data.start + client:GetAimVector() * 96
		data.filter = client
	
		local target = util.TraceLine(data).Entity
		data = nil
	
		if (IsValid(target) and target:IsPlayer()) then
			local medical = client:GetCharacter():GetAttribute("medical", 0)
	
			if medical >= item.medAttr then
				client.beingUsed = item
	
				ix.util.PlayerPerformBlackScreenAction(item.player, "Обработка ран...", 6, function(player)
					if (not IsValid(client) or not client:Alive()) then
						client.beingUsed = nil
						return
					end
	
					healPlayer(client, target, item.healAmount, item.healSeconds, medical)
	
					if item.healInfectationSeconds > 0 and target.HealInfectation then
						target:HealInfectation(item.healInfectationSeconds)
					end
	
					if math.random() <= 0.25 then
						ix.Wounds:SetBleeding(target)
						client:Notify("Вы вызвали кровотечение во время полевой хирургии. Используйте гемостатическое средство.")
					end
	
					client.beingUsed = nil
	
					local quantity = item:GetData("quantity", item.quantity)
					if quantity > 1 then
						item:SetData("quantity", quantity - 1)
					else
						item:Remove()
					end
				end)
	
				local character = client:GetCharacter()
				local name = character:GetName()
	
				local quantity = item:GetData("quantity", item.quantity)
				if quantity > 1 then
					ix.chat.Send(client, "me", " обрабатывает раны "..target:GetName()..", используя хирургический набор. Осталось "..(quantity-1).." использований.")
				else
					ix.chat.Send(client, "me", " обрабатывает раны "..target:GetName()..", используя последний хирургический набор.")
				end
			else
				client:Notify("Недостаточно медицинских знаний.")
			end
		end
	
		return false
	end,
	
	OnCanRun = function(item)
		local cur_item = item.player.beingUsed
	
		if cur_item and cur_item == item then
			cur_item = nil
			return false
		end
	
		return true
	end
}

/*
ITEM.functions.use_on = {
	name = "Обработать чужие раны",
	icon = "icon16/pill_go.png",
	OnRun = function(item)
		local client = item.player

		local data = {}
		data.start = client:GetShootPos()
		data.endpos = data.start + client:GetAimVector() * 96
		data.filter = client

		local target = util.TraceLine(data).Entity
		data = nil

		if (IsValid(target) and target:IsPlayer()) then
			local medical = client:GetCharacter():GetAttribute("medical", 0)

			if medical >= item.medAttr then
				client.beingUsed = item

				ix.util.PlayerPerformBlackScreenAction(item.player, "Обработка ран...", 4, function(player)
					if (not IsValid(client) or not client:Alive()) then
						client.beingUsed = nil
						return
					end

					healPlayer(client, target, item.healAmount, item.healSeconds, medical)

					if item.healInfectationSeconds > 0 and target.HealInfectation then
						target:HealInfectation(item.healInfectationSeconds)
					end

					client.beingUsed = nil

					local quantity = item:GetData("quantity", item.quantity)
					if quantity > 1 then
						item:SetData("quantity", quantity - 1)
					else
						item.player:EmitSound(item.sound)
						item:Remove()
					end
				end)

				local character = client:GetCharacter()
				local name = character:GetName()

				local quantity = item:GetData("quantity", item.quantity)
				if quantity > 1 then
					ix.chat.Send(client, "me", " обрабатывает раны "..target:GetName()..", используя хирургический набор. Осталось "..(quantity-1).." использований.")
				else
					ix.chat.Send(client, "me", " обрабатывает раны "..target:GetName()..", используя последний хирургический набор.")
				end
			else
				client:Notify("Недостаточно медицинских знаний.")
			end
		end

		return false
	end,

	OnCanRun = function(item)
		local cur_item = item.player.beingUsed

		if cur_item and cur_item == item then
			cur_item = nil
			return false
		end

		return true
	end
}
*/
function ITEM:GetDescription()
	local quant = self:GetData("quantity", self.ammoAmount or self.quantity or 0)
	local quantdesc = ""
	local invdesc = ""
	if self.longdesc then
		invdesc = "\n\n"..(self.longdesc)
	end

	if self.quantdesc then
		quantdesc = "\n\n"..Format(self.quantdesc, quant)
	end

	if (self.entity) then
		return (self.description)
	else
        return (self.description..quantdesc..invdesc)
	end
end

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		draw.SimpleText(item:GetData("quantity", item.quantity).."/"..item.quantity, "stalkerregularinvfont", 3, h - 1, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, color_black)
	end
end

function ITEM:PopulateTooltip(tooltip)
    if (self.PopulateTooltipIndividual) then
      self:PopulateTooltipIndividual(tooltip)
    end
end

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.quantity))
end