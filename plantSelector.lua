-------------------------
-- Mandatory Table
-------------------------

local T = {}


-------------------------
-- Requires
-------------------------

local selectorTileMgr = require "selectorTile"


-------------------------
-- Callable Functions
-------------------------

local refresh = function(plantSelector)
	local index = 0
	for index = 1, #plantSelector do
		selectorTileMgr.refresh(plantSelector[index])
		
		if (plantSelector[index].definition ~= "" and plantSelector[index].sunCost <= _G.SUN) then
			plantSelector[index].enabled = true
		else
			plantSelector[index].enabled = false
		end
	end	
end

T.refresh = refresh


-------------------------
-- Mandatory Constructor
-------------------------

local create = function()
	local plantSelector = {}
	
	local selectorTile = nil
	local column = 0
	local x = 30
	local y = 30

	for column = 1, 8 do
		selectorTile = selectorTileMgr.create(x, y)
		plantSelector[column] = selectorTile
		
		if (column == 1) then
			selectorTile.image = display.newImageRect("image/sunFlower.png", 40, 40, false)
			selectorTile.image:setReferencePoint(display.CenterReferencePoint)
			selectorTile.image.x = selectorTile.x
			selectorTile.image.y = selectorTile.y
			selectorTile.definition = "sunFlower"
			selectorTile.sunCost = 3
		elseif (column == 2) then
			selectorTile.image = display.newImageRect("image/shootingPlant.png", 40, 40, false)
			selectorTile.image:setReferencePoint(display.CenterReferencePoint)
			selectorTile.image.x = selectorTile.x
			selectorTile.image.y = selectorTile.y			
			selectorTile.definition = "shootingPlant"
			selectorTile.sunCost = 5
		else
			selectorTile.image = nil
			selectorTile.definition = ""
			sunCost = 5
		end
		
		x = x + 60
	end
	
	_G.PLANTSELECTOR = plantSelector
	return plantSelector
end

T.create = create


-------------------------
-- Mandatory Destructor
-------------------------

local destroyMgr = function()
end

T.destroyMgr = destroyMgr

local destroy = function(plantSelector)
	if (plantSelector == nil) then return end
	local index = 0
	
	for index = 1, #T.plantSelector do
		display.remove(T.plantSelector[index].image)
		T.plantSelector[index].image = nil	
		display.remove(T.plantSelector[index])
		T.plantSelector[index] = nil
	end
	
	display.remove(plantSelector)
	plantSelector = nil
end

T.destroy = destroy


-------------------------
-- Mandatory Return
-------------------------

return T