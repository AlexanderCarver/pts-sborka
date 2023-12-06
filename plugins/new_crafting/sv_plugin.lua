netstream.Hook("ixCraftItem", function(ply, data, data2)
	local id = data[1]
	local recipe = STORED_RECIPES[id]
	local requirements = recipe["req"]
	local results = recipe["results"]
	local skills = recipe["skills"]
	local guns = recipe["guns"] or false
	local workstation = recipe["workstation"] or false
	local tools = recipe["tools"] or false
	local tier = recipe["tier"]
	local missing = {}
	local char = ply:GetChar()
	local inv = char:GetInventory()

	for k, v in pairs(requirements) do
		if inv:GetItemCount(k) < v then
			local i = ix.item.Get(k)
			missing[#missing + 1] = i.name
		end
	end

	if #missing > 0 then
		ply:Notify("You dont have enought items for create it! Need: " .. table.concat(missing, ", "))

		return false
	end

	if skills then
		for k, v in pairs(skills) do
			local attribute = ply:GetCharacter():GetAttribute(k, 0)
			if (attribute and attribute < v) then
				ply:Notify("You dont have enought attributes for create this.")

				return false
			end
		end
	end

	if workstation then
		local station = ply:GetEyeTraceNoCursor().Entity
		if(!station.GetItemID or (station.GetItemID and workstation ~= station:GetItemID()) or ply:GetPos():Distance(station:GetPos()) >= 100) then
			ply:Notify("You are not looking to the workstation.")

			return false
		end
	end

	if tools then
		if !inv:HasItems(tools) then
			ply:Notify("You dont have the necessary tools for create this.")
			return false
		end
	end

	ply:Notify("You create correctly the item.")

	for k, v in pairs(requirements) do

		for i = 1, v do

			local item = inv:HasItem(k)
			if !item.isTool then
				item:Remove()
			end
		end
	end

	for k, v in pairs(results) do
		inv:Add(k, v)
	end

	if skills then
		for k, _ in pairs(skills) do
			local att = ply:GetCharacter()
			local attribute = att:GetAttribute(k, 0)
			if (tier == "I" and attribute < 25) then
				att:UpdateAttrib(k, 0.01)
			end
			if (tier == "II" and attribute < 50) then
				att:UpdateAttrib(k, 0.008)
			end
			if (tier == "III" and attribute < 75) then
				att:UpdateAttrib(k, 0.005)
			end
			if (tier == "IV") then
				att:UpdateAttrib(k, 0.001)
			end
		end
	end

	ix.log.AddRaw(ply:Name() .. "has made a recipe and received: " .. table.concat(results, ", "))
end)
