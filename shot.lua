-------------------------
-- Mandatory Table
-------------------------

local T = {}


-------------------------
-- Callable Functions
-------------------------

local refresh = function(shot)
	if (shot == nil) then
		return
	end
	
	if (shot.active and shot.x >= _G.W + (shot.width / 2)) then
		shot.active = false
	end
	
	if (shot.active == false) then
		display.remove(shot)
		shot = nil
	end
end

T.refresh = refresh

-------------------------
-- Mandatory Constructor
-------------------------

local create = function(definition, posX, posY)
	local shot = display.newImageRect("image/shot.png", 15, 15, false)
	shot:setReferencePoint(display.CenterReferencePoint)
	shot.x = posX
	shot.y = posY
	
	physics.addBody(shot, { density = 0, friction = 0, bounce = 0, radius = 1 })
	
	shot.definition = definition
	shot.bodyType = "dynamic"
	shot:setLinearVelocity(30, 0)
	shot.isSensor = true
	shot.active = true
	
	return shot
end

T.create = create


-------------------------
-- Mandatory Destructor
-------------------------

local destroyMgr = function()
end

T.destroyMgr = destroyMgr

local destroy = function(shot)
	if (shot == nil) then return end
	display.remove(shot.body)
	shot.body = nil
	display.remove(shot)
	shot = nil
end

T.destroy = destroy


-------------------------
-- Mandatory Return
-------------------------

return T