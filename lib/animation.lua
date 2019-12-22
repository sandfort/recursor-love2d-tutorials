local Class = require("lib.class")
local Animation = Class:derive("Animation")
local Vector2 = require("lib.vector2")

function Animation:new(xoff, yoff, w, h, frames, ncols, fps, loop)
  self.fps = fps
  if type(frames) == "table" then
    self.frames = frames
  else
    self.frames = {}
    for i = 1, frames do
      self.frames[i] = i
    end
  end
  self.num_columns = ncols
  self.start_offset = Vector2(xoff, yoff)
  self.offset = Vector2()
  self.size = Vector2(w, h)
  self.loop = loop == nil or loop -- default to true

  self:reset()
end

function Animation:reset()
  self.timer = 1 / self.fps
  self.index = 1
  self.done = false

  self.offset.x = self.start_offset.x + (self.size.x * ((self.frames[self.index] - 1) % (self.num_columns)))
      self.offset.y = self.start_offset.y + (self.size.y * math.floor((self.frames[self.index] - 1) / self.num_columns))
end

function Animation:set(quad)
  quad:setViewport(self.offset.x, self.offset.y, self.size.x, self.size.y)
end

function Animation:update(dt, quad)
  if #self.frames <= 1 then
    return
  elseif self.timer > 0 then
    self.timer = self.timer - dt
  
    if self.timer <= 0 then
      self.timer = 1 / self.fps
      self.index = self.index + 1
      if self.index > #self.frames then
        if self.loop then
          self.index = 1
        else
          self.index = #self.frames
          self.timer = 0
          self.done = true
        end
      end
      self.offset.x = self.start_offset.x + (self.size.x * ((self.frames[self.index] - 1) % (self.num_columns)))
      self.offset.y = self.start_offset.y + (self.size.y * math.floor((self.frames[self.index] - 1) / self.num_columns))
      quad:setViewport(self.offset.x, self.offset.y, self.size.x, self.size.y)
    end
  end
end

return Animation
