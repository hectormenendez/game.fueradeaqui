-------------------------
-- Mandatory Table
-------------------------

local T = {}


-------------------------
-- Aux Functions
-------------------------

local touchSun = function(event)
	local xScale = event.target.xScale
	local yScale = event.target.yScale

	if (event.phase == "began") then
		local endAnimation = function()
			display.remove(event.target)
			event.target = nil
		end
		
		local animation = function()
			transitionStash.newTransition = transition.to(event.target, {time=200, xScale=xScale*3, yScale=yScale*3, alpha=.5, onComplete=endAnimation})
		end
		
		_G.SUN = _G.SUN + 1
		animation()
	end
end


-------------------------
-- Mandatory Constructor
-------------------------

local create = function(posX, posY)
	local sun = display.newImageRect("image/sun.png", 25, 25, false)
	sun:setReferencePoint(display.CenterReferencePoint)
	sun.x = posX
	sun.y = posY
	sun:addEventListener("touch", touchSun)
	return sun
end

T.create = create


-------------------------
-- Mandatory Destructor
-------------------------

local destroyMgr = function()
end

T.destroyMgr = destroyMgr

local destroy = function(sun)
	if (sun == nil) then return end
	display.remove(sun)
	sun = nil
end

T.destroy = destroy


-------------------------
-- Mandatory Return
-------------------------

return T