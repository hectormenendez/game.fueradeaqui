-------------------------
-- Mandatory Table
-------------------------

local T = {}


-------------------------
-- Local Variables
-------------------------

local tileSheet = sprite.newSpriteSheetRetina("image/tile.png", 60, 60)
local tileSet = sprite.newSpriteSet(tileSheet, 1, 1)
sprite.add(tileSet, "tile", 1, 1, 600, 0)


-------------------------
-- Aux Functions
-------------------------

local touchTile = function(event)
	local index = 0
	
	if (event.phase == "began") then
		if (event.target.selected) then
			event.target.selected = false
		elseif (event.target.enabled) then
			for index = 1, #_G.PLANTSELECTOR do
				_G.PLANTSELECTOR[index].selected = false
			end		
			event.target.selected = true
		end
	end
end


-------------------------
-- Callable Functions
-------------------------

local refresh = function(tile)
	if (tile.selected == true) then
		tile:setFillColor(255, 0, 0, 255)
	else
		tile:setFillColor(255, 255, 255, 255)
	end
	
	if (tile.image ~= nil) then
		if (tile.enabled) then
			tile.image.alpha = 1
		else
			tile.image.alpha = .5
		end
	end
end

T.refresh = refresh


-------------------------
-- Mandatory Constructor
-------------------------

local create = function(posX, posY)
	local tile = sprite.newSprite(tileSet)
	tile:setReferencePoint(display.CenterReferencePoint)
	tile.x = posX
	tile.y = posY
	tile:pause()
	tile:prepare("tile")
	tile:play()
	tile.selected = false
	tile.enabled = false
	tile:addEventListener("touch", touchTile)
	return tile
end

T.create = create


-------------------------
-- Mandatory Destructor
-------------------------

local destroyMgr = function()
	display.remove(tileSet)
	tileSet = nil
	tileSheet:dispose()
	tileSheet = nil
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