ITEM.name = "Кувалда"
ITEM.description = "Инструмент для быстрого деконструирования баррикад."
ITEM.model = "models/mark2580/gtav/garage_stuff/impexp_hammer.mdl"
ITEM.time = 15
ITEM.width = 1
ITEM.height = 2


ITEM.functions.Destroy = {
	name = "Деконструкция",
	tip = "Destroy Object",
	icon = "icon16/delete.png",
	OnRun = function(item)
		local client = item.player
		local trace = client:GetEyeTraceNoCursor() 
		local entTrace = trace.Entity
		
		client:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0), item.time-0.1, 0.1 )
		client:SetAction("Строительные работы...", item.time)
		client:DoStaredAction(entTrace, function() 

			entTrace:Remove()
			client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0), item.time-0.1, 1 )
			
		end, item.time)
		
		return false	
	end,
	OnCanRun = function(item)
		local client = item.player
		local trace = client:GetEyeTraceNoCursor() 
		local entTrace = trace.Entity
		 
		return !IsValid(item.entity) and IsValid(client) and entTrace:GetClass() == "prop_physics" 
	end
}


