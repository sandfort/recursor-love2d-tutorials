local Class = require("lib.class")
local Vector2 = require("lib.vector2")

local Button = Class:derive("Button")

local function color(r, g, b, a)
  return {r, g or r, b or r, a or 1}
end

local function gray(level, alpha)
  return {level, level, level, alpha or 1}
end

function Button:new(x, y, w, h)
  self.pos = Vector2(x or 0, y or 0)
  self.w = w
  self.h = h
  
  self.normal = color(0.5, 0.125, 0.125, 0.75)
  self.highlight = color(0.5, 0.125, 0.125, 1)
  self.pressed = color(1, 0.125, 0.125, 1)
  self.disabled = gray(0.5, 0.5)
end

function Button:left(x)
  self.pos.x = x + self.w / 2
end

function Button:top(y)
  self.pos.y = y + self.h / 2
end

function Button:draw()
  local r, g, b, a = love.graphics.getColor()
  love.graphics.setColor(self.normal)
  love.graphics.rectangle("fill", self.pos.x - self.w / 2, self.pos.y - self.h / 2, self.w, self.h, 4, 4)
  love.graphics.setColor(r, g, b, a)
  love.graphics.print("New", self.pos.x - 20, self.pos.y - 25)
end

return Button
