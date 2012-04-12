module(..., package.seeall)

function new()

	-------------------------
	-- Scene Setup
	-------------------------

	local localGroup = display.newGroup()
	local splash = display.newImageRect("image/splash_0.png", _G.W, _G.H, false)
	splash:setReferencePoint(display.CenterReferencePoint)
	splash.x = _G.W / 2
	splash.y = _G.H / 2
	localGroup:insert(splash)


	-------------------------
	-- Aux Functions
	-------------------------

	local function destroyEverything()
		cancelAllTimers()
		display.remove(localGroup)
		localGroup = nil
	end

	local function gotoGame()
		destroyEverything()
		director:changeScene("game")
	end

	timerStash.newTimer = timer.performWithDelay(5000, gotoGame)


	-------------------------
	-- Mandatory Return
	-------------------------

	return localGroup
end
