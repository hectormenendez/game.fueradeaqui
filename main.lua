-------------------------
-- Requires
-------------------------

physics = require "physics"
director = require "director"


-------------------------
-- Settings
-------------------------

display.setStatusBar(display.HiddenStatusBar)
system.setIdleTimer(false)
io.output():setvbuf("no")


-------------------------
-- Global Variables
-------------------------
-- Tiempo de espera para  el primer zombies
_G.startTime = 1000

-- Intervalo entr zombies
_G.zombieTime = 6000

_G.shotVelocity = 90

-- Globals to set screen size
_G.W = display.contentWidth
_G.H = display.contentHeight

-- Memory monitor on Console
_G.DEBUGMONITOR = false

-- Global to access plantSelector from selectorTile
_G.PLANTSELECTOR = nil

-- Global to stop creating zombies at completion or failing
_G.STOPGAME = false

-- Global to destroy remaining shots at failing
_G.DESTROYSHOTS = false

-- Global to access sun collected from everywhere
_G.SUN = 100


-------------------------
-- Memory Warning (iOS only)
-------------------------

local handleLowMemory = function( event )
	print("OS memory warning received!")
end

Runtime:addEventListener("memoryWarning", handleLowMemory)


-------------------------
-- Memory Monitor
-------------------------

local monitorMem = function()
    collectgarbage()
    print( "MemUsage: " .. collectgarbage("count") )
    local textMem = system.getInfo( "textureMemoryUsed" ) / 1000000
    print( "TexMem:   " .. textMem )
end

if (_G.DEBUGMONITOR) then
	Runtime:addEventListener("enterFrame", monitorMem)
end


-------------------------
-- Timer Cancel
-------------------------

timerStash = {}

cancelAllTimers = function()
    local k, v

    for k,v in pairs(timerStash) do
        timer.cancel( v )
        v = nil; k = nil
    end

    timerStash = nil
    timerStash = {}
end


-------------------------
-- Transition Cancel
-------------------------

transitionStash = {}

cancelAllTransitions = function()
    local k, v

    for k,v in pairs(transitionStash) do
        transition.cancel( v )
        v = nil; k = nil
    end

    transitionStash = nil
    transitionStash = {}
end


-------------------------
-- Main Function
-------------------------

local mainGroup = display.newGroup()

--local backgroundMusic = audio.loadStream("image/background.mp3")
--local backgroundMusicChannel = audio.play( backgroundMusic, { channel=1, loops=-1, fadein=50 }


local main = function()
	math.randomseed(os.time())
	mainGroup:insert(director.directorView)
	director:changeScene("loadGame")
	return true
end


-------------------------
-- Mandatory Call
-------------------------

main()
