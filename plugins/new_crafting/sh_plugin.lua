--TODO: POPULATE CRAFTING ITEMS AND RECIPES
PLUGIN.name = "Crafting"
PLUGIN.author = "Huargenn"
PLUGIN.desc = "Replacing the business menu with crafting because that's a more sensible thing to do."
STORED_RECIPES = {}

function PLUGIN:AddRecipe(name, model, desc, requirements, results, id, skills, blueprint, workstation, tools, tier, entity, category)
	if type(name) ~= "table" then
		local RECIPE = {}
		RECIPE["id"] = id --Unique ID of the recipe.
		RECIPE["name"] = name -- Name of the recipe.
		RECIPE["model"] = model -- Model it uses in the menu.
		RECIPE["desc"] = desc -- Description of what it is.
		RECIPE["req"] = requirements --Requirements to craft it(use item id's)
		RECIPE["results"] = results --Results of the craft (use item id's)
		RECIPE["blueprint"] = blueprint or false
		RECIPE["entity"] = entity or false
		RECIPE["category"] = category or "Miscellaneous"
		RECIPE["workstation"] = workstation or false
		RECIPE["tools"] = tools or false
		RECIPE["tier"] = tier or "I"

		if skills then
			RECIPE["skills"] = skills
		end

		STORED_RECIPES[id] = RECIPE
	else
		for k, v in pairs(name) do
			RECIPE["id"] = k --Unique ID of the recipe.
			RECIPE["name"] = v.name -- Name of the recipe.
			RECIPE["model"] = v.model -- Model it uses in the menu.
			RECIPE["desc"] = v.desc -- Description of what it is.
			RECIPE["req"] = v.requirements --Requirements to craft it(use item id's)
			RECIPE["results"] = v.results --Results of the craft (use item id's)
			RECIPE["blueprint"] = v.blueprint or false --Whether or not it uses a blueprint
			RECIPE["entity"] = v.entity or false --FUTURE: Whether or not it will use an entity.
			RECIPE["category"] = v.category or "Miscellaneous" --FUTURE: The Category
			RECIPE["workstation"] = v.workstation or false
			RECIPE["tools"] = v.tools or false
			RECIPE["tier"] = v.tier or "I"

			if skills then
				RECIPE["skills"] = skills
			end
		end
	end
end
--[[-------------------------------------------------------------------------
TODO: For release, demonstrate full capacity of plugin.
---------------------------------------------------------------------------]]
local NEW_RECIPES = {

	--Unique ID = name of the folders of attributes


	    --[[For example]]--


	--[[
	["nucleo_ia"] = {
		["name"] = "Droide: Núcleo de I.A.",
		["model"] = "models/props/starwars/weapons/ap_mine.mdl",
		["desc"] = "Un núcleo de Inteligencia Artificial.",
		["requirements"] = {["lingote_titanio"] = 2, ["circuito_cobre"] = 3, ["tabla_circuitos_oro_cobre"] = 2, ["sensor"] = 2, ["conjunto_piezas_metalicas"] = 4},
		["skills"] = {["eng"] = 35, ["des"] = 30},
		["tools"] = {"planos_nucleo_ia", "destornillador", "soldador", "tijeras", "martillo"},
		["results"] = {["nucleo_ia"] = 1},
		["workstation"] = "estacion_droides",
		["tier"] = "I",
		["category"] = "Ingenieria",
	},
	]]
	-- Weapons & Ammo
	["wep_bow"] = {
		["name"] = "Weapon: value_bolts",
		["model"] = "models/weapons/yurie_rustalpha/wm-huntingbow.mdl",
		["desc"] = "Create a bow which utilizes makeshift arrows from scratch.",
		["requirements"] = {["value_bolts"] = 2},
		["results"] = {["value_capacitors"] = 2},
		["category"] = "Weapons",
		["skills"] = {["eng"] = 0},
		["category"] = "Weapons",
	}
}


for k, v in pairs(NEW_RECIPES) do
	PLUGIN:AddRecipe(v.name, v.model, v.desc, v.requirements, v.results, k, v.skills or nil, v.blueprint or nil, v.workstation or nil, v.tools or nil, v.tier, v.entity or nil, v.category or "Miscellaneous")
end

--[[-------------------------------------------------------------------------
Tying in with the 'Citizen Production Plugin', adding schematics for study.
---------------------------------------------------------------------------]]
for k, v in pairs(ix.item.list) do
	if v.category == "Schematics" then
		local tbl = v.requirements
		local tbl2 = v.result
		local req_table_empty = {}
		local res_table_empty = {}
		for k2, v2 in pairs(tbl) do
			req_table_empty[v2[1]] = v2[2]
		end
		for k3,v3 in pairs(tbl2) do
			if v3[1] != "manufacturing_ticket" then
				res_table_empty[v3[1]] = v3[2]
			end
		end
		PLUGIN:AddRecipe(v.name, v.model, v.description .. "\nYou studied this blueprint from the factories.", req_table_empty, res_table_empty, v.uniqueID, false, v.uniqueID)
	end
end

ix.util.Include("cl_plugin.lua")
ix.util.Include("sv_plugin.lua")
ix.util.Include("sh_items.lua")

ix.command.Add("BlueprintGive", {
	description = "Give a blueprint to a player.",
	adminOnly = true,
	arguments = {ix.type.character, ix.type.string},
	OnRun = function(self, client, target, blueprint)
		local data = target:GetData("blueprints", {})

		if not table.HasValue(data, blueprint) then
			table.insert(data, blueprint)
		else
			client:Notify(target:GetName() .. " already has this blueprint.")

			return
		end

		target:SetData("blueprints", data)
		client:Notify("You have given " .. target:GetName() .. " the blueprint " .. blueprint .. ".")
		target.player:Notify("You have been given the blueprint " .. blueprint .. " by " .. client:Name())
	end
})

ix.command.Add("BlueprintRemove", {
	description = "Give a blueprint to a player.",
	adminOnly = true,
	arguments = {ix.type.character, ix.type.string},
	OnRun = function(self, client, target, blueprint)
		local data = target:GetData("blueprints", {})

		if table.HasValue(data, blueprint) then
			table.RemoveByValue(data, blueprint)
		else
			client:Notify(target:GetName() .. " does not have this blueprint.")
		end

		target:SetData("blueprints", data)
		client:Notify("You have taken " .. target:GetName() .. " the blueprint " .. blueprint .. ".")
		target.player:Notify("You have had the blueprint " .. blueprint .. " taken from you by " .. client:Name())
	end
})

local charMeta = ix.meta.character

function charMeta:GiveBlueprint(blueprint)
	local data = self:GetData("blueprints", {})

	if not table.HasValue(data, blueprint) then
		table.insert(data, blueprint)
	end

	self:SetData("blueprints", data)
end

function charMeta:RemoveBlueprint(blueprint)
	local data = target:GetData("blueprints", {})

	if table.HasValue(data, blueprint) then
		table.RemoveByValue(data, blueprint)
	end

	target:SetData("blueprints", data)
end