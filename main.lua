local Animation = require("animation")
local Sprite = require("sprite")

local hero_atlas

local spr
local walk = Animation(16, 32, 16, 16, 6, 6, 12)
local swim = Animation(16, 64, 16, 16, 6, 6, 12)

function love.load()
  love.graphics.setDefaultFilter("nearest", "nearest")
  hero_atlas = love.graphics.newImage("assets/gfx/hero.png")

  spr = Sprite(hero_atlas, 16, 16, 100, 100, 10, 10, 45)
  spr:add_animation("walk", walk)
  spr:add_animation("swim", swim)
  spr:animate("swim")
end

function love.update(dt)
  if dt > 0.035 then return end
  
  spr:update(dt)
end

function love.draw()
  love.graphics.clear(.25, .25, 1)
  spr:draw()
end
