local Class = require("lib.class")
local Scene = require("lib.scene")
local SceneManager = Class:derive("SceneManager")

function SceneManager:new(scene_dir, scenes)
  self.scenes = {}
  
  if not scene_dir then scene_dir = "" end
  
  if scenes ~= nil then
    assert(type(scenes) == "table", "parameter scenes must be a table!")
    for i = 1, #scenes do
      local m = require(scene_dir.."."..scenes[i])
      assert(m:is(Scene), "File: "..scene_dir.."."..".lua is not a Scene!")
      self.scenes[scenes[i]] = m(self)
    end
  end

  -- strings that are keys into the self.scenes table
  self.prev_scene_name = nil
  self.current_scene_name = nil
  
  -- the actual Scene object
  self.current = nil
end

function SceneManager:add(scene, scene_name)
  if scene then
    assert(type(scene_name) == "string", "parameter scene_name must be a string!")
    assert(scene:is(Scene), "cannot add non-Scene object to the SceneManager!")
    self.scenes[scene_name] = scene
  end
end

function SceneManager:remove(scene_name)
  if scene_name then
    for k, v in pairs(self.scenes) do
      if k == scene_name then
        self.scenes[k]:destroy()
        self.scenes[k] = nil
        if scene_name == self.current_scene_name then
          self.current = nil
        end
        break
      end
    end
  end
end

function SceneManager:switch(next_scene)
  if self.current_scene ~= nil then
    self.current_scene:exit()
  end
  
  if next_scene then
    assert(self.scenes[next_scene] ~= nil, "unable to find scene: "..next_scene)
    self.prev_scene_name = self.current_scene_name
    self.current_scene_name = next_scene
    self.current = self.scenes[next_scene]
    self.current:enter()
  end
end

function SceneManager:pop()
  if self.prev_scene_name then
    self:switch(prev_scene_name)
    self.prev_scene_name = nil
  end
end

function SceneManager:get_available_scenes()
  local scene_names = {}
  for k, v in pairs(self.scenes) do
    scene_names[#scene_names + 1] = k
  end
  return scene_names
end

function SceneManager:update(dt)
  if self.current then
    self.current:update(dt)
  end
end

function SceneManager:draw()
  if self.current then
    self.current:draw()
  end
end

return SceneManager
