local Class = require("class")
local Animation = Class:derive("Animation")
local Vector2 = require("vector2")

function Animation:new(xoff, yoff, w, h, nframes, ncols, fps, loop)
  self.fps = fps
  self.num_frames = nframes
  self.num_columns = ncols
  self.start_offset = Vector2(xoff, yoff)
  self.offset = Vector2()
  self.size = Vector2(w, h)
  self.loop = loop == nil or loop -- default to true

  self:reset()
end

function Animation:reset()
  self.timer = 1 / self.fps
  self.frame = 1
  self.done = false
  self.offset.x = self.start_offset.x
  self.offset.y = self.start_offset.y
end

function Animation:set(quad)
  quad:setViewport(self.offset.x, self.offset.y, self.size.x, self.size.y)
end

function Animation:update(dt, quad)
  if self.num_frames <= 1 then
    return
  elseif self.timer > 0 then
    self.timer = self.timer - dt
  
    if self.timer <= 0 then
      self.timer = 1 / self.fps
      self.frame = self.frame + 1
      if self.frame > self.num_frames then
        if self.loop then
          self.frame = 1
        else
          self.frame = self.num_frames
          self.timer = 0
          self.done = true
        end
      end
      self.offset.x = self.start_offset.x + (self.size.x * ((self.frame - 1) % (self.num_columns)))
      self.offset.y = self.start_offset.y + (self.size.y * math.floor((self.frame - 1) / self.num_columns))
      quad:setViewport(self.offset.x, self.offset.y, self.size.x, self.size.y)
    end
  end
end

return Animation
