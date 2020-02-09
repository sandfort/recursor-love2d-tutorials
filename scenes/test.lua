local Animation = require("lib.animation")
local Sprite = require("lib.sprite")
local Scene = require("lib.scene")

local Test = Scene:derive("Test")

local hero_atlas

local spr
local idle = Animation(16, 16, 16, 16, 4, 4, 6)
local walk = Animation(16, 32, 16, 16, {1, 2, 3, 4, 5, 6}, 6, 12)
local swim = Animation(16, 64, 16, 16, 6, 6, 12)
local punch= Animation(16, 80, 16, 16, 3, 3, 8, false)
local snd

function Test:new(scene_mgr)
  self.super:new(scene_mgr)
  
  hero_atlas = love.graphics.newImage("assets/gfx/hero.png")

  spr = Sprite(hero_atlas, 16, 16, 100, 100, 10, 10)

  spr:add_animations{
    idle = idle,
    walk = walk,
    swim = swim,
    punch = punch
  }
  spr:animate("swim")

  snd = love.audio.newSource("assets/sfx/hit01.wav", "static")
end

local entered = false
function Test:enter()
  if not entered then
    entered = true
    print("enter test")
  end
end

function Test:update(dt)
--  if Keyboard:key_down("space") and spr.current_anim ~= "punch" then
--    love.audio.stop(snd)
--    love.audio.play(snd)
--    spr:animate("punch")
--  elseif Keyboard:key_down("escape") then
--    love.event.quit()
--  end

--  if spr.current_anim == "punch" and spr:animation_finished() then
--    spr:animate("idle")
--  end

  spr:update(dt)
end

function Test:draw()
  love.graphics.clear(.25, .25, 1)
  spr:draw()
end

return Test
