local Scene = require("lib.scene")

local MainMenu = Scene:derive("MainMenu")

function MainMenu:draw()
  love.graphics.print("Hello from main menu", 200, 250)
end

return MainMenu
