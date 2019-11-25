local Animation = require("animation")

local hero_atlas
local hero_sprite

--animation parameters
local fps = 12
local anim_timer = 1 / fps
local frame = 1
local num_frames = 6
local xoffset

local a = Animation(16, 32, 16, 16, 6, 6, 12)

function love.load()
  love.graphics.setDefaultFilter("nearest", "nearest")
  hero_atlas = love.graphics.newImage("assets/gfx/hero.png")
  hero_sprite = love.graphics.newQuad(16, 32, 16, 16, hero_atlas:getDimensions())  
end

function love.update(dt)
  if dt > 0.035 then return end
  
  a:update(dt, hero_sprite)
end

function love.draw()
  love.graphics.clear(.25, .25, 1)
  love.graphics.draw(hero_atlas, hero_sprite, 320, 180, 0, 10, 10, 8, 8)
end
