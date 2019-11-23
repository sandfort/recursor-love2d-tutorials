local hero_atlas
local hero_sprite

--animation parameters
local fps = 12
local anim_timer = 1 / fps
local frame = 1
local num_frames = 6
local xoffset

function love.load()
  love.graphics.setDefaultFilter("nearest", "nearest")
  hero_atlas = love.graphics.newImage("assets/gfx/hero.png")
  hero_sprite = love.graphics.newQuad(16, 32, 16, 16, hero_atlas:getDimensions())
end

function love.update(dt)
  if dt > 0.035 then return end -- lag guard thingie again

  anim_timer = anim_timer - dt
  
  if anim_timer <= 0 then
    anim_timer = 1 / fps
    frame = frame + 1
    if frame > num_frames then frame = 1 end
    xoffset = 16 * frame
    hero_sprite:setViewport(xoffset, 32, 16, 16)
  end
end

function love.draw()
  -- last two arguments are "origin offset"
  -- setting these to 8 (half of the sprite's height and width)
  -- means that it will rotate from its center
  -- rather than the upper left corner, as it would by default
  love.graphics.draw(hero_atlas, hero_sprite, 320, 180, 0, 10, 10, 8, 8)
end
