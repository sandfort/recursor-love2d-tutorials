local Class = require("class")
local Animation = require("animation")
local Vector2 = require("vector2")

local Sprite = Class:derive("Sprite")

function Sprite:new(atlas, w, h, x, y, sx, sy, angle)
  self.w = w
  self.h = h
  self.x = x
  self.y = y
  self.pos = Vector2(x or 0, y or 0)
  self.atlas = atlas
  self.animations = {}
  self.current_anim = ""
  self.quad = love.graphics.newQuad(0, 0, w, h, atlas:getDimensions())
  self.scale = Vector2(sx or 1, sy or 1)
  self.angle = angle or 0
end

function Sprite:animate(anim_name)
  if self.current_anim ~= anim_name and self.animations[anim_name] ~= nil then
    self.current_anim = anim_name
    self.animations[anim_name]:reset()
    self.animations[anim_name]:set(self.quad)
  end
end

function Sprite:animation_finished()
  if self.animations[self.current_anim] ~= nil  then
    return self.animations[self.current_anim].done
  end
  
  return true
end

function Sprite:add_animation(name, anim)
  self.animations[name] = anim
end

function Sprite:update(dt)
  if self.animations[self.current_anim] ~= nil then
    self.animations[self.current_anim]:update(dt, self.quad)
  end
end

function Sprite:draw()
  love.graphics.draw(self.atlas, self.quad, self.x, self.y, self.angle, self.scale.x, self.scale.y, self.w / 2, self.h / 2)
end

return Sprite
