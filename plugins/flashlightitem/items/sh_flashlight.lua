ITEM.name = "Налобный фонарь Fenix HM65R"
ITEM.description = "Универсальный налобный фонарь с ближним и дальним светом, который отлично помогает ориентироваться в тёмных пространствах. Достаточно удобный вариант для туризма, работы, активного отдыха и... Выживания."
ITEM.model = "models/equipmentpack/usgearammopouch1.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.120

ITEM:Hook("drop", function(item)
	item.player:Flashlight(false)
end)
