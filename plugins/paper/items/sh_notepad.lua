ITEM.name = "Notepad"
ITEM.model = "models/props_lab/clipboard.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.description = "A notepad of which one you can write on."
ITEM.price = 0
ITEM.chance = 31
ITEM.functions.use = {
	name = "Write",
	icon = "icon16/pencil.png",
	OnRun = function(item)
		local client = item.player
		local id = item:GetID()
		if (id) then
			netstream.Start(client, "receivePaper", id, item:GetData("PaperData") or "")
		end
		return false
	end
}
