local Class = require("lib.class")
local Animation = require("lib.animation")
local Vector2 = require("lib.vector2")

local Sprite = Class:derive("Sprite")

function Sprite:new(atlas, x, y, w, h, sx, sy, angle)
  self.w = w
  self.h = h
  self.flip = Vector2(1, 1)
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

function Sprite:flip_h(flip)
  if flip then
    self.flip.x = -1
  else
    self.flip.x = 1
  end
end

function Sprite:flip_v(flip)
  if flip then
    self.flip.y = -1
  else
    self.flip.y = 1
  end
end

function Sprite:animation_finished()
  if self.animations[self.current_anim] ~= nil  then
    return self.animations[self.current_anim].done
  end
  
  return true
end

function Sprite:add_animations(animations)
  assert(type(animations) == "table", "animations parameter must be a table!")
  for k, v in pairs(animations) do
    self.animations[k] = v
  end
end

function Sprite:update(dt)
  if self.animations[self.current_anim] ~= nil then
    self.animations[self.current_anim]:update(dt, self.quad)
  end
end

function Sprite:draw()
  love.graphics.draw(self.atlas, self.quad, self.pos.x, self.pos.y, self.angle, self.scale.x * self.flip.x, self.scale.y * self.flip.y, self.w / 2, self.h / 2)
end

return Sprite
