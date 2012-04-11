-------------------------
-- Mandatory Table
-------------------------

local T = {}


-------------------------
-- Requires
-------------------------

local plantMgr = require "plant"


-------------------------
-- Aux Functions
-------------------------

local touchTile = function(event)
	if (event.phase == "began") then
		event.target.selected = true
	end
end


-------------------------
-- Callable Functions
-------------------------

local refresh = function(tile, plantSelector, plants, gameTime)
	local plant = nil
	local plantDefinition = nil
	local index = 0
	local sunCost = 0
	
	if (tile.selected and tile.enabled) then
		for index = 1, #plantSelector do
			if (plantSelector[index].enabled and plantSelector[index].selected) then
				plantDefinition = plantSelector[index].definition
				plantSelector[index].selected = false
				sunCost = plantSelector[index].sunCost
			end
		end
	
		if (plantDefinition ~= nil) then
			plant = plantMgr.create(plantDefinition, tile.x, tile.y, gameTime)
			plants[#plants + 1] = plant
			plant.body.tile = tile
			tile.parent:insert(plant)
			tile.enabled = false
			_G.SUN = _G.SUN - sunCost
		end
	end
	
	tile.selected = false
end

T.refresh = refresh


-------------------------
-- Mandatory Constructor
-------------------------

local create = function(posX, posY)
	local tile = display.newImageRect("image/tile.png", 60, 60, false)
	tile:setReferencePoint(display.CenterReferencePoint)
	tile.x = posX
	tile.y = posY
	tile.selected = false
	tile.enabled = true
	tile:addEventListener("touch", touchTile)
	return tile
end

T.create = create


-------------------------
-- Mandatory Destructor
-------------------------

local destroyMgr = function()
	plantMgr.destroyMgr()
	plantMgr = nil
end

T.destroyMgr = destroyMgr

local destroy = function(tile)
	if (tile == nil) then return end
	display.remove(tile)
	tile = nil
end

T.destroy = destroy


-------------------------
-- Mandatory Return
-------------------------

return T