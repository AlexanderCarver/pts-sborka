ITEM.name = "Хирургический набор"
ITEM.description = "Маленький докторский саквояж со всем необходимым."
ITEM.longdesc = "Специальная сумка, в которой лежат обезболивающие средства, антисептики, скальпел и зажимы. Содержит всё необходимое, чтобы быстро заштопать серьёзные раны, однако требует соответствующих навыков."
ITEM.model = "models/illusion/eftcontainers/docbag.mdl"

ITEM.width = 2
ITEM.height = 2

ITEM.quantity = 6
ITEM.price = 0
ITEM.healAmount = 100
ITEM.medAttr = 0
ITEM.healRevive = false
ITEM.healReviveSeconds = 40

ITEM.weight = 0.085
ITEM.flatweight = 0.130

ITEM.exRender = false
ITEM.iconCam = {
    pos = Vector(0, 0, 200),
    ang = Angle(0, 0, 0),
    fov = 8.42
}

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc2(tooltip, "Хирургия", Color(64, 224, 208), Material("vgui/ui/stalker/armorupgrades/bleeding2.png"))
end