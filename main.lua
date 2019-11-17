local x = 120
local dir = 1

function love.update(dt)
  if x >= 400 or x < 120 then
    dir = dir * -1
    x = x + 1 * dir
  end
  x = x + dir * 200 * dt
end

function love.draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.print("hello canvas", 10, 100)
  love.graphics.setColor(0.5, 0.25, 1)
  love.graphics.rectangle("fill", x, 100, 100, 50)
end
