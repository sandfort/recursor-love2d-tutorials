local Class = require("lib.class")
local Events = require("lib.events")

local GamePadManager = Class:derive("GamePadManager")

local DEAD_ZONE = 0.1

local function hook_love_events(self)
  function love.joystickadded(joystick)
    local id = joystick:getID()
    print("connecting controller "..id)
    assert(self.connected_sticks[id] == nil, "joystick "..id.." already exists!")
    self.connected_sticks[id] = joystick
    self.is_connected[id] = true
    self.button_map[id] = {}
    self.events:invoke("controller_added", id)
  end

  function love.joystickremoved(joystick)
    local id = joystick:getID()
    print("disconnecting controller "..id)
    self.connected_sticks[id] = nil
    self.is_connected[id] = false
    self.button_map[id] = nil
    self.events:invoke("controller_removed", id)
  end
  
  function love.gamepadpressed(joystick, button)
    local id = joystick:getID()
    self.button_map[id][button] = true
  end

  function love.gamepadreleased(joystick, button)
    local id = joystick:getID()
    self.button_map[id][button] = false
  end
end

function GamePadManager:new(db_files, analog_enabled)
  if db_files ~= nil then
    for i = 1, #db_files do
      love.joystick.loadGamepadMappings(db_files[i])
    end
  end
  
  self.events = Events()
  self.events:add("controller_removed")
  self.events:add("controller_added")

  hook_love_events(self)

  self.analog_enabled = analog_enabled

  self.connected_sticks = {}
  self.is_connected = {}
  self.button_map = {}  
end

function GamePadManager:exists(joy_id)
  return self.is_connected == nil and self.is_connected[joy_id]
end

function GamePadManager:get_stick(joy_id)
  return self.connected_sticks[joy_id]
end

-- return true if the button was just pressed
function GamePadManager:button_down(joy_id, button)
  if self.is_connected[joy_id] == nil or self.is_connected[joy_id] == false then 
      return false
    else 
      return self.button_map[joy_id][button] == true
    end
end

-- return true if the button was just released
function GamePadManager:button_up(joy_id, button)
  if self.is_connected[joy_id] == nil or self.is_connected[joy_id] == false then
    return false
  else
    return self.button_map[joy_id][button] == false
  end
end

-- return true if the given button was pressed for the joystick id in this frame
function GamePadManager:button(joy_id, button)
  local stick = self.connected_sticks[joy_id]
  if self.is_connected[joy_id] == nil or self.is_connected[joy_id] == false then return false end

  local is_down = stick:isGamepadDown(button)
  
  if self.analog_enabled and not is_down then

    local xAxis = stick:getGamepadAxis("leftx")
    local yAxis = stick:getGamepadAxis("lefty")

    if button == "dpright" then
      is_down = xAxis > DEAD_ZONE
    elseif button == "dpleft" then
      is_down = xAxis < -DEAD_ZONE
    elseif button == "dpup" then
      is_down = yAxis > DEAD_ZONE
    elseif button == "dpdown" then
      is_down = yAxis < -DEAD_ZONE
    end
  end

  return is_down
end

function GamePadManager:update(dt)
  for i = 1, #self.is_connected do
    if self.button_map[i] then 
      for k,_ in pairs(self.button_map[i]) do
        self.button_map[i][k] = nil
      end
    end
  end
end

return GamePadManager
