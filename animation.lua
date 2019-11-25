local Class = require("class")
local Animation = Class:derive("Animation")
local Vector2 = require("vector2")

function Animation:new(xoff, yoff, w, h, ncols, nframes, fps)
  self.fps = fps
  self.timer = 1 / self.fps
  self.frame = 1
  self.num_frames = nframes
  self.num_columns = ncols
  self.start_offset = Vector2(xoff, yoff)
  self.offset = Vector2()
  self.size = Vector2(w, h)
end

function Animation:reset()
  self.timer = 1 / self.fps
  self.frame = 1
end

function Animation:update(dt, quad)
  self.timer = self.timer - dt
  
  if self.timer <= 0 then
    self.timer = 1 / self.fps
    self.frame = self.frame + 1
    if self.frame > self.num_frames then
      self.frame = 1
    end
    self.offset.x = self.start_offset.x + (self.size.x * (self.frame - 1))
    self.offset.y = self.start_offset.y + (self.size.y * math.floor((self.frame - 1) / self.num_columns))
    quad:setViewport(self.offset.x, self.offset.y, self.size.x, self.size.y)
  end
end

return Animation
