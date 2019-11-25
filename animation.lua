local Class = require("class")
local Animation = Class:derive("Animation")
local Vector2 = require("vector2")

function Animation:new()
  self.fps =
  self.timer = 1 / self.fps
  self.frame =
  self.num_frames =
  self.offset = Vector2()
  self.size = Vector2()
end

function Animation:update(dt)
  self.timer = self.timer - dt
  
  if self.timer <= 0 then
    self.timer = 1 / self.fps
    self.frame = self.frame + 1
    if self.frame > self.num_frames then
      self.frame = 1
    end
    self.offset.x = self.size.x * self.frame
    hero_sprite:setViewport(self.offset.x, 32, 16, 16)
  end
end

return Animation
