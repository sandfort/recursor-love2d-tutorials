local Class = require("class")
local Vector2 = Class:derive("Vector2")

function Vector2:new(x, y)
  self.x = x or 0
  self.y = y or 0
end

-- TODO: other vector functions

return Vector2
