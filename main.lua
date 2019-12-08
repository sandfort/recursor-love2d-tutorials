local Animation = require("animation")
local Sprite = require("sprite")

local hero_atlas

local spr
local idle = Animation(16, 16, 16, 16, 4, 4, 6)
local walk = Animation(16, 32, 16, 16, 6, 6, 12)
local swim = Animation(16, 64, 16, 16, 6, 6, 12)
local punch= Animation(16, 80, 16, 16, 3, 3, 8, false)
local snd

function love.load()
  love.graphics.setDefaultFilter("nearest", "nearest")
  hero_atlas = love.graphics.newImage("assets/gfx/hero.png")

  spr = Sprite(hero_atlas, 16, 16, 100, 100, 10, 10)
  spr:add_animation("idle", idle)
  spr:add_animation("walk", walk)
  spr:add_animation("swim", swim)
  spr:add_animation("punch", punch)
  spr:animate("idle")
  
  snd = love.audio.newSource("assets/sfx/hit01.wav", "static")
end

function love.update(dt)
  if dt > 0.035 then return end

  if spr.current_anim == "punch" and spr:animation_finished() then
    spr:animate("idle")
  end
  
  spr:update(dt)
end

function love.draw()
  love.graphics.clear(.25, .25, 1)
  spr:draw()
end

function love.keypressed(key)
  if key == "space" and spr.current_anim ~= "punch" then
    love.audio.stop(snd)
    love.audio.play(snd)
    spr:animate("punch")
  elseif key == "a" then
  elseif key == "d" then
    spr:flip_h(false)
  elseif key == "w" then
    spr:flip_v(true)
  elseif key == "s" then
    spr:flip_v(false)
  end
end
