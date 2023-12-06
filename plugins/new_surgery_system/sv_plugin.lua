function PLUGIN:CanPlayerTradeWithVendor(client, _, uniqueID)
	for _, v in pairs(ix.item.instances) do
		if uniqueID and v.uniqueID == uniqueID and client.beingUsed and client.beingUsed == v then
			return false
		end
	end
end