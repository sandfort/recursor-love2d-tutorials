Keyboard = require("lib.keyboard")
local Events = require("lib.events")
local GamePadManager = require("lib.gamepadmgr")
local SceneManager = require("lib.scenemgr")

local e
local scene_mgr

local gpm = GamePadManager({"assets/gamecontrollerdb.txt"})

function love.load()
  love.graphics.setDefaultFilter("nearest", "nearest")
  local font = love.graphics.newFont("assets/Pixeled.ttf", 16)
  love.graphics.setFont(font)
  
  gpm.events:hook("controller_added", on_controller_added)
  gpm.events:hook("controller_removed", on_controller_removed)
  
  scene_mgr = SceneManager("scenes", {"mainmenu", "test"})
  scene_mgr:switch("mainmenu")
end

function on_controller_added(joy_id)
  print("controller "..joy_id.." added")
end

function on_controller_removed(joy_id)
  print("controller "..joy_id.." removed")
end

function love.update(dt)
  if dt > 0.035 then return end
  
  if Keyboard:key_down(",") then
    scene_mgr:switch("mainmenu")
  elseif Keyboard:key_down(".") then
    scene_mgr:switch("test")
  end
  
  scene_mgr:update(dt)
  Keyboard:update(dt)
  gpm:update(dt)
end

function love.draw()
  scene_mgr:draw()
end
