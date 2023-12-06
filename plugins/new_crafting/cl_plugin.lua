surface.CreateFont("WastelandTiny", {
	font = "alsina", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 13,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false
})

surface.CreateFont("WastelandMedium", {
	font = "alsina", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 26,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false
})

surface.CreateFont("WastelandStandard", {
	font = "alsina", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 35,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false
})

local PANEL = {}

function PANEL:Init()
	self.infolabel = self:Add("DLabel")
	self.infolabel:Dock(TOP)
	self.infolabel:SetContentAlignment(5)
	self.infolabel:SetExpensiveShadow(1, Color(0, 0, 0, 255))
	self.infolabel:SetText("Hover over an object icon for more details.")
	self.infolabel:SetFont("WastelandMedium")
	ix.gui.crafting = self
	self:SetSize(ScrW() / 1.5, ScrH() / 1.5)
	self:Center()
	self.CraftingList = self:Add("DScrollPanel")
	self.CraftingList:Dock(FILL)
	-- Set the color of the Scroll Bar
	local scroll = self.CraftingList:GetVBar()
	function scroll.btnGrip:Paint(w, h)
		draw.RoundedBox(8, 2.25, 0, w - 5, h - 5, Color(255, 61, 0))
	end

	local w, h = self:GetSize()

	for k, v in SortedPairsByMemberValue(STORED_RECIPES, "name") do

		--printTable(v)
		if v["blueprint"] then
			local data = LocalPlayer():GetCharacter():GetData("blueprints", {})

			--print(v["blueprint"])
			if table.HasValue(data, v["blueprint"]) then
				local item = self:AddItem(v["name"], v["model"], v["desc"], v["req"], v["results"], v["skills"], v["blueprint"], v["workstation"], v["tools"], v["entity"])
				item.id = v["id"]
			end
		end

		if not v["blueprint"] then
			local item = self:AddItem(v["name"], v["model"], v["desc"], v["req"], v["results"], v["skills"], false, v["workstation"], v["tools"], v["entity"])
			item.id = v["id"]
		end
	end
end

function PANEL:AddItem(name, icon, desc, req, results, skills, blueprint, workstation, tools, entity)
	self.test = self:Add("CraftingListItem")
	self.test:SetItem(name, icon, desc, req, results, skills, blueprint or false, workstation or false, tools or false, entity or false)
	self.CraftingList:AddItem(self.test)
	--self.test:DockMargin(0,0,0,5)

	return self.test
end

vgui.Register("CraftingListFrame", PANEL, "DPanel")
local PANEL = {}

function PANEL:Init()
	local size = self:GetParent():GetSize()
	self:SetWide(size / 2)
	self:SetTall(size / 8)
	self:Dock(TOP)
	local w, h = self:GetSize()
	self.spawnicon = self:Add("SpawnIcon")
	self.spawnicon:SetSize(100, 100)
	self.spawnicon:SetPos(5, 5)
	self:SetModel("icon")
	self.labelitem = self:Add("DLabel")
	self.labelitem:Dock(TOP)
	self.labelitem:SetFont("WastelandStandard")
	self.labelitem:SetText("")
	self.labelitem:SetAutoStretchVertical(true)
	self.labelitem:DockMargin(120, 25, 0, 0)
	self.labelitemdesc = self:Add("DLabel")
	self.labelitemdesc:Dock(TOP)
	self.labelitemdesc:SetFont("WastelandMedium")
	self.labelitemdesc:SetText("")
	self.labelitemdesc:SetAutoStretchVertical(true)
	self.labelitemdesc:DockMargin(120, 0, 0, 0)
	self.labelitemreq = self:Add("DLabel")
	self.labelitemreq:Dock(TOP)
	self.labelitemreq:SetFont("WastelandMedium")
	self.labelitemreq:SetText("")
	self.labelitemreq:SetAutoStretchVertical(true)
	self.labelitemreq:DockMargin(120, 0, 0, 0)
	self.craftbutton = self:Add("DButton")
	self.craftbutton:SetText("")
	self.craftbutton:AlignRight(-365)
	self.craftbutton:AlignTop(45)
	self.craftbutton:SetSize(150, 40)

	function self.craftbutton:Paint(w2, h2)
		local col

		if self:GetParent():HasRequirements() then
			col = Color(0, 150, 0, 150)
		else
			col = Color(75, 75, 75, 150)
		end

		surface.SetDrawColor(col)
		surface.DrawRect(0, 0, w2, h2)
		surface.SetDrawColor(0, 0, 0, 255)
		surface.DrawOutlinedRect(0, 0, w2, h2)
		draw.SimpleTextOutlined("Create", "WastelandStandard", w2 - 115, h2 / 20, Color(255, 255, 255, 255), 5, 5, 1, Color(0, 0, 0, 255))
	end

	function self.craftbutton:DoClick()
		surface.PlaySound("UI/buttonclick.wav")

		timer.Simple(SoundDuration("UI/buttonclick.wav") - 0.1, function()
			surface.PlaySound("UI/buttonclickrelease.wav")
		end)
		local parent = self:GetParent()
		netstream.Start("ixCraftItem", {parent.id})
	end
end

function PANEL:SetItem(name, icon, desc, req, results, skills, blueprint, workstation, tools, entity)
	--creating identifiers
	self.labelitem:SetText(name)
	self.spawnicon:SetModel(icon)
	self.description = desc
	self.labelitemdesc:SetText(desc)
	self.requirements = req
	local realreqd = {}

	for k, v in pairs(self.requirements) do
		local item = ix.item.Get(k)

		if (!item) then
			ErrorNoHalt("Recipe: " .. name .. " has invalid requirement: " .. k)
			return
		end

		realreqd[#realreqd + 1] = item.name .. " (" .. v .. "x)"
	end

	self.labelitemreq:SetText("Requirements: " .. table.concat(realreqd, ", "))
	self.results = results
	self.skills = skills
	self.blueprint = blueprint
	self.workstation = workstation
	self.tools = tools
	self.entity = entity
	--self.item = ix.items.list[item]
	self.spawnicon:SetHelixTooltip(function(tooltip)
		local title = tooltip:AddRow("title")
		local configColor = ix.config.Get("color")
		title:SetBackgroundColor(Color(configColor.r, configColor.g, configColor.b, 255))
		title:SetImportant()
		title:SetText(self.labelitem:GetText())
		title:SizeToContents()
		local description = tooltip:AddRow("description")
		description:SetBackgroundColor(Color(0, 0, 0, 255))
		description:SetText(self.labelitemdesc:GetText())
		description:SizeToContents()
		local requirements = tooltip:AddRow("requirements")
		local realreq = {}

		for k, v in pairs(self.requirements) do
			local item = ix.item.Get(k)
			realreq[#realreq + 1] = item.name .. " (" .. v .. "x)"
		end

		requirements:SetText("Requirements: " .. table.concat(realreq, ", "))
		local missing = {}
		local inv = LocalPlayer():GetCharacter():GetInventory()

		for k, v in pairs(self.requirements) do
			if inv:GetItemCount(k) < v then
				local i = ix.item.Get(k)
				missing[#missing + 1] = i.name
			end
		end

		if #missing > 0 then
			requirements:SetBackgroundColor(derma.GetColor("Warning", tooltip))
		else
			requirements:SetBackgroundColor(derma.GetColor("Success", tooltip))
		end


		if #realreq >= 7 then
			requirements:SizeToContents()
			requirements:SetTall(100)
		elseif #realreq >= 4 then
			requirements:SizeToContents()
			requirements:SetTall(56)
		else
			requirements:SizeToContents()
		end

		if self.skills then
			local skill = tooltip:AddRow("skill")
			local skillist = {}

			for k, v in pairs(self.skills) do
				local attrib = ix.attributes.list[k]
				skillist[#skillist + 1] = attrib.name .. " (" .. v .. ")"
			end

			skill:SetText("Required skills: " .. table.concat(skillist, ", "))
			skill:SizeToContents()
			local skillslist = {}

			for k, v in pairs(self.skills) do
				if LocalPlayer():GetCharacter():GetAttribute(k, 0) < v then
					skillslist[#skillslist + 1] = k
				end
			end

			if #skillslist > 0 then
				skill:SetBackgroundColor(derma.GetColor("Error", tooltip))
			else
				skill:SetBackgroundColor(derma.GetColor("Success", tooltip))
			end
		else
			local skill = tooltip:AddRow("skill")
			skill:SetText("Skills not required")
			skill:SizeToContents()
		end

		if self.workstation then
			local workstation = tooltip:AddRow("workstation")
			workstation:SetText("Workstation: " .. ix.item.list[self.workstation].name)
			workstation:SizeToContents()

			local lookingEntity = LocalPlayer():GetEyeTraceNoCursor().Entity
			if (lookingEntity.GetItemID and lookingEntity:GetItemID() == self.workstation and LocalPlayer():GetPos():Distance(lookingEntity:GetPos()) <= 100) then
				workstation:SetBackgroundColor(derma.GetColor("Success", tooltip))
			else
				workstation:SetBackgroundColor(derma.GetColor("Error", tooltip))
			end

		end

		if self.tools then
			local tool = tooltip:AddRow("tools")
			local inv = LocalPlayer():GetChar():GetInventory()
			local rtools = {}

			for k, v in pairs(self.tools) do
				rtools[#rtools + 1] = ix.item.list[k].name
			end

			tool:SetText("Required tools: " .. table.concat(rtools, ", "))
			tool:SizeToContents()

			if !inv:HasItems(tools) then
				tool:SetBackgroundColor(derma.GetColor("Error", tooltip))
			else
				tool:SetBackgroundColor(derma.GetColor("Success", tooltip))
			end
		end

		local results = tooltip:AddRow("results")
		local realres = {}

		for k, v in pairs(self.results) do
			local item = ix.item.Get(k)
			realres[#realres + 1] = item.name .. " (" .. v .. "x)"
		end

		results:SetText("Results: " .. table.concat(realres, ", "))
		results:SizeToContents()

		if self.blueprint then
			local bp = tooltip:AddRow("blueprint")
			bp:SetColor(ix.config.Get("color"))
			bp:SetText("Unlocked by blueprints")
			bp:SizeToContents()
		end
	end)

end

function PANEL:Paint(w, h)
	surface.SetDrawColor(0, 0, 0, 175)
	surface.DrawRect(0, 0, w, h)

end

function PANEL:HasRequirements()
	local inv = LocalPlayer():GetCharacter():GetInventory()
	local missing = {}
	for k, v in pairs(self.requirements) do
		if inv:GetItemCount(k) < v then
			local item = ix.item.Get(k)
			if (!item) then
				return false
			end

			missing[#missing + 1] = item.name
		end
	end

	if #missing > 0 then
		return false
	end

	if self.skills then
		for k, v in pairs(self.skills) do
			local attribute = LocalPlayer():GetCharacter():GetAttribute(k, 0)
			if (attribute and attribute < v) then
				return false
			end
		end
	end

	if self.workstation then
		local station = LocalPlayer():GetEyeTraceNoCursor().Entity
		if(!station.GetItemID or (station.GetItemID and self.workstation ~= station:GetItemID()) or LocalPlayer():GetPos():Distance(station:GetPos()) >= 100) then
			return false
		end
	end

	if self.tools then
		if !inv:HasItems(self.tools) then
			return false
		else
			return true
		end
	end

	return true
end

vgui.Register("CraftingListItem", PANEL, "DPanel")

hook.Add("CreateMenuButtons", "ixCrafting", function(tabs)
	tabs["fabrication"] = function(container)
		container:Add("CraftingListFrame")
	end
end)