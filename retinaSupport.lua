-------------------------
-- Retina RoundedRect
-------------------------

local cacheRoundedRect = {}
cacheRoundedRect.newRoundedRect = display.newRoundedRect
display.newRoundedRect = function(group, xPos, yPos, width, height, angle)
	local r = cacheRoundedRect.newRoundedRect(group, 0, 0, width * 2, height * 2, angle * 2)
	r.xScale, r.yScale, r.x, r.y = .5, .5, xPos, yPos
	return r
end


-------------------------
-- Retina Circle
-------------------------

local cacheCircle = {}
cacheCircle.newCircle = display.newCircle
display.newCircle = function(xPos, yPos, radius)
	local c = cacheCircle.newCircle(0, 0, radius * 2)
	c.xScale, c.yScale, c.x, c.y = .5, .5, xPos, yPos
	if (display.contentScaleX == .5) then c.xScale, c.yScale = .25, .25 end
	return c
end


-------------------------
-- Retina SpriteSheet
-------------------------

-- This one demands code update
-- We use 'newSpriteSheetRetina' instead of 'newSpriteSheet' ...
-- because Lime uses the second one and we can't modify it

-- Also, we are assuming the image suffix is '@2x'
-- We don't read it from config file to keep things simple

local cacheSheet = {}
cacheSheet.newSpriteSheet = sprite.newSpriteSheet
sprite.newSpriteSheetRetina = function(path, width, height)
	local newPath = ""
	if (display.contentScaleX == .5) then
		newPath = string.gsub(path, ".png", "@2x.png")
		width = width * 2
		height = height * 2
	else
		newPath = path
	end
	
	local h = cacheSheet.newSpriteSheet(newPath, width, height)
	return h
end
	

-------------------------
-- Retina Sprite
-------------------------

local cacheSprite = {}
cacheSprite.newSprite = sprite.newSprite
sprite.newSprite = function(spriteSheet)
	local s = cacheSprite.newSprite(spriteSheet)
	if (display.contentScaleX == .5) then s.xScale, s.yScale = .5, .5 end
	return s
end