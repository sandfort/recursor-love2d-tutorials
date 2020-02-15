local Scene = require("lib.scene")
local Button = require("lib.ui.button")

local MainMenu = Scene:derive("MainMenu")

function MainMenu:new(scene_mgr)
  self.super(scene_mgr)
  self.button = Button(100, 100, 125, 40)
  
  self.button:left(0)
end

function MainMenu:draw()
  self.button:draw()
  love.graphics.print("Hello from main menu", 200, 25)
end

return MainMenu
