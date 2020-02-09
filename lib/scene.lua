local Class = require("lib.class")

local Scene = Class:derive("Scene")

function Scene:new(scene_mgr)
  self.scene_mgr = scene_mgr
end

function Scene:enter() end
function Scene:update(dt) end
function Scene:draw() end
function Scene:destroy() end
function Scene:exit() end

return Scene
