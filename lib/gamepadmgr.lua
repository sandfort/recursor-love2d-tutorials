local Class = require("lib.class")

local GamePadManager = Class:derive("GamePadManager")

local function hook_love_events(self)
  function love.joystickadded(joystick)
    local id = joystick:getID()
    assert(self.connected_sticks[id] == nil, "joystick "..id.." already exists!")
    self.connected_sticks[id] = joystick
    self.is_connected[id] = true
    self.button_map[id] = {}
    -- TODO: invoke a 'controller_added' event here
  end

  function love.joystickremoved(joystick)
    local id = joystick:getID()
    self.connected_sticks[id] = nil
    self.is_connected[id] = false
    self.button_map[id] = nil
    -- TODO: invoke a 'controller_removed' event here
  end
  
  function love.gamepadpressed(joystick, button)
    local id = joystick:getID()
    self.button_map[id][button] = nil
  end

  function love.gamepadreleased(joystick, button)
    local id = joystick:getID()
    self.button_map[id][button] = false
  end
end

function GamePadManager:new(db_files)
  if db_files ~= nil then
    for i = 1, #db_files do
      love.joystick.loadGamepadMappings(db_files[i])
    end
  end
  
  self.connected_sticks = {}
  self.is_connected = {}
  self.button_map = {}
  
  hook_love_events(self)
end

-- return true if the button was just pressed
function GamePadManager:button_down(joy_id, button)
  if self.is_connected[id] == nil or self.is_connected == false then
    return false
  else
    return self.button_map[joy_id][button] == true
  end
end

-- return true if the button was just released
function GamePadManager:button_up(joy_id, button)
  if self.is_connected[id] == nil or self.is_connected == false then
    return false
  else
    return self.button_map[joy_id][button] == false
  end
end

-- return true if the given button was pressed for the joystick id in this frame
function GamePadManager:button(joy_id, button)
  local stick = self.connected_sticks[joy_id]
  if self.is_connected[id] == nil or self.is_connected == false then
    return false
  end
  
  local is_down = stick:isGamepadDown(button)
  
  return is_down
end

function GamePadManager:update(dt)
  -- TODO: update the button states for all connected joysticks
end

return GamePadManager
