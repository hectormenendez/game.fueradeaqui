-------------------------
-- Mandatory Table
-------------------------

local T = {}


-------------------------
-- Local Variables
-------------------------

local shootingPlantSheet = sprite.newSpriteSheetRetina("image/shootingPlant.png", 60, 60)
local shootingPlantSet = sprite.newSpriteSet(shootingPlantSheet, 1, 1)
sprite.add(shootingPlantSet, "shootingPlant", 1, 1, 600, 0)

local sunFlowerSheet = sprite.newSpriteSheetRetina("image/sunFlower.png", 60, 60)
local sunFlowerSet = sprite.newSpriteSet(sunFlowerSheet, 1, 1)
sprite.add(sunFlowerSet, "sunFlower", 1, 1, 600, 0)


-------------------------
-- Requires
-------------------------

sunMgr = require "sun"
shotMgr = require "shot"


-------------------------
-- Aux Functions
-------------------------

local createShootingPlant = function()
	local plant = sprite.newSprite(shootingPlantSet)
	plant.waitTime = 10000
	plant.hits = 5
	plant.shootTime = 2000
	plant.lastShootTime = 0
	return plant
end

local createSunFlower = function()
	local plant = sprite.newSprite(sunFlowerSet)
	plant.waitTime = 5000
	plant.sunTime = 5000
	plant.hits = 3
	return plant
end

local refreshSunFlower = function(plant, gameTime)
	local sun = nil
	
	if (plant.creationTime < gameTime - plant.sunTime) then
		plant.creationTime = gameTime
		sun = sunMgr.create(plant.x + 20, plant.y + 20)
		plant.parent:insert(sun)
	end
end

local refreshShootingPlant = function(plant, gameTime, zombies, shots)
	local shot = nil
	local index = 0
	local shoot = false

	for index = 1, #zombies do
		if (zombies[index].y == plant.y and zombies[index] ~= nil and _G.STOPGAME == false) then
			shoot = true
		end
	end

	if (shoot and plant.lastShootTime < gameTime - plant.shootTime) then
		plant.lastShootTime = gameTime
		shot = shotMgr.create("shot", plant.x + 20, plant.y - 15)
		shots[#shots + 1] = shot
		plant.parent:insert(shot)
	end
end


-------------------------
-- Callable Functions
-------------------------

local refresh = function(plant, gameTime, zombies, shots)
	if (_G.STOPGAME or plant.body == nil) then
		return
	end

	local unTint = function()
		plant:setFillColor(255, 255, 255, 255)
	end
	
	if (plant.body.hits == 0) then
		plant.isVisible = false
		plant.body.tile.enabled = true
		display.remove(plant.body)
		plant.body = nil
		display.remove(plant)
		plant = nil
		return
	end
	
	if (plant.definition == "sunFlower") then
		refreshSunFlower(plant, gameTime)
	end
	
	if (plant.definition == "shootingPlant") then
		refreshShootingPlant(plant, gameTime, zombies, shots)
	end
end

T.refresh = refresh


-------------------------
-- Mandatory Constructor
-------------------------

local create = function(definition, posX, posY, gameTime)
	local plant = nil
	
	if (definition == "shootingPlant") then
		plant = createShootingPlant()
	end
	
	if (definition == "sunFlower") then
		plant = createSunFlower()
	end
	
	plant.definition = definition
	plant:setReferencePoint(display.CenterReferencePoint)
	plant.x = posX
	plant.y = posY
	plant.creationTime = gameTime
	
	plant.body = display.newCircle(plant.x, plant.y, plant.width / 2)
	plant.body:setReferencePoint(display.CenterReferencePoint)
	plant.body.x = plant.x
	plant.body.y = plant.y
	plant.body.active = true

	physics.addBody(plant.body, { density = 0, friction = 0, bounce = 0, radius = 1 })
	
	plant.body.definition = definition
	plant.body.isVisible = false
	plant.body.isFixedRotation = true
	plant.bodyType = "static"
	
	if (definition == "shootingPlant") then
		plant.body.hits = 5
	end
	
	if (definition == "sunFlower") then
		plant.body.hits = 3
	end
	
	return plant
end

T.create = create


-------------------------
-- Mandatory Destructor
-------------------------

local destroyMgr = function()
	display.remove(shootingPlantSet)
	shootingPlantSet = nil
	shootingPlantSheet:dispose()
	shootingPlantSheet = nil
	
	display.remove(sunFlowerSet)
	sunFlowerSet = nil
	sunFlowerSheet:dispose()
	sunFlowerSheet = nil
	
	display.remove(sunMgr)
	sunMgr = nil
end

T.destroyMgr = destroyMgr

local destroy = function(plant)
	if (plant == nil) then return end
	display.remove(plant.body)
	plant.body = nil	
	display.remove(plant)
	plant = nil
end

T.destroy = destroy


-------------------------
-- Mandatory Return
-------------------------

return T