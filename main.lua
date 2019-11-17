local x = 120
local dir = 1

function love.update(dt)
  -- pauses updating if dt is very high
  if dt > 0.040 then return end

  if x < 120 then
    dir = 1
  elseif x > 400 then
    dir = -1
  end
  x = x + dir * 200 * dt
end

function love.draw()
  -- can't you set the color on individual draw function calls?
  love.graphics.setColor(1, 1, 1)
  love.graphics.print("hello canvas", 10, 100)
  love.graphics.setColor(0.5, 0.25, 1)
  love.graphics.rectangle("fill", x, 100, 100, 50)
end
