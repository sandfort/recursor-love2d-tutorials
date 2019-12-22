local Animation = require("lib.animation")
local Sprite = require("lib.sprite")
local Keyboard = require("lib.keyboard")
local Events = require("lib.events")

local hero_atlas

local spr
local idle = Animation(16, 16, 16, 16, 4, 4, 6)
local walk = Animation(16, 32, 16, 16, {1, 2, 3, 4, 5, 6}, 6, 12)
local swim = Animation(16, 64, 16, 16, 6, 6, 12)
local punch= Animation(16, 80, 16, 16, 3, 3, 8, false)
local snd
local e

function love.load()
  Keyboard:hook_love_events()
  love.graphics.setDefaultFilter("nearest", "nearest")
  hero_atlas = love.graphics.newImage("assets/gfx/hero.png")

  spr = Sprite(hero_atlas, 16, 16, 100, 100, 10, 10)
  spr:add_animation("idle", idle)
  spr:add_animation("walk", walk)
  spr:add_animation("swim", swim)
  spr:add_animation("punch", punch)
  spr:animate("walk")
  
  e = Events()
  e:add("on_space")
  e:hook("on_space", on_space)
  
  snd = love.audio.newSource("assets/sfx/hit01.wav", "static")
end

function on_space()
  print("spaced!")
end

function love.update(dt)
  if dt > 0.035 then return end
  
  if Keyboard:key_down("space") and spr.current_anim ~= "punch" then
    love.audio.stop(snd)
    love.audio.play(snd)
    spr:animate("punch")
    e:invoke("on_space")
  elseif Keyboard:key_down("u") then
    e:unhook("on_space", on_space)
  elseif Keyboard:key_down("escape") then
    love.event.quit()
  end

  if spr.current_anim == "punch" and spr:animation_finished() then
    spr:animate("idle")
  end
  
  Keyboard:update(dt)
  spr:update(dt)
end

function love.draw()
  love.graphics.clear(.25, .25, 1)
  spr:draw()
end
