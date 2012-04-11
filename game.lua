module(..., package.seeall)

function new() 
	
	-------------------------
	-- Requires
	-------------------------

	local levelMgr = require "level"


	-------------------------
	-- Game Variables
	-------------------------

	-- Actual time
	local gameTime = 0
	
	-- Time for the first zombie
	local startTime = 10000
	
	-- Time to stop creating zombies
	local endTime = 180000
	
	-- Time to create another zombie
	local zombieTime = 10000


	-------------------------
	-- Scene Setup
	-------------------------

	local gameGroup = display.newGroup()
	startTime = system.getTimer() + startTime
	local level = levelMgr.create(startTime, endTime, zombieTime)
	gameGroup:insert(level)
	level.isVisible = true


	-------------------------
	-- Game Functions
	-------------------------
	
	local destroyEverything = function()
		Runtime:removeEventListener("enterFrame", refreshGame)
		cancelAllTimers()
		cancelAllTransitions()

		levelMgr.destroy()
		level = nil
		levelMgr.destroyMgr()
		levelMgr = nil
		display.remove(gameGroup)
		gameGroup = nil
	end

	
	-------------------------
	-- Game Loop
	-------------------------
	
	local refreshGame = function()
		gameTime = system.getTimer()
		levelMgr.refresh(gameTime)		
	end
	
	Runtime:addEventListener("enterFrame", refreshGame)
	
	
	-------------------------
	-- Mandatory Return
	-------------------------	

	return gameGroup
	
end