local utils = require "utils"
local color = require "color"
require "conf"

local ship = {}

-- helpful for shape stuff
local halfWidth = SHIPWIDTH / 2
local halfHeight = SHIPHEIGHT / 2

-- create new player ship
function ship.createShip()
    local s = {}
    s.position = { x = SCREENWIDTH / 2, y = SHIP_POSITION_Y }
    s.velocity = { x = 0, y = 0 }
    s.rotation = 0
    s.fill = color.mint
    s.p1 = { x = -halfWidth, y = -halfHeight }
    s.p2 = { x = 0, y = halfHeight }
    s.p3 = { x = halfWidth, y = -halfHeight }
    return s
end

-- update player ship values
function ship.update( s )
    -- apply inertia
    if s.velocity.x > 0.1 then
        s.velocity.x = s.velocity.x - INERTIA
    elseif s.velocity.x < -0.1 then
        s.velocity.x = s.velocity.x + INERTIA
    end
    -- apply rotation inertia
    if s.rotation > 0.1 then
        s.rotation = s.rotation - ROTATION_INERTIA
    elseif s.rotation < -0.1 then
        s.rotation = s.rotation + ROTATION_INERTIA
    end
    -- add velocity to position
    s.position.x = s.position.x + s.velocity.x
    -- check for out of bounds
    if s.position.x < PLAY_PADDING + SHIPWIDTH / 2 then
        s.position.x = PLAY_PADDING + SHIPWIDTH / 2
    elseif s.position.x > PLAY_WIDTH + PLAY_PADDING - SHIPWIDTH / 2 then
        s.position.x = PLAY_WIDTH + PLAY_PADDING - SHIPWIDTH / 2
    end
    -- rotate triangle points
    s.p1 = utils.rotateVector({x = -halfWidth, y = -halfHeight}, s.rotation)
    s.p2 = utils.rotateVector({x = 0, y = halfHeight}, s.rotation)
    s.p3 = utils.rotateVector({x = halfWidth, y = -halfHeight}, s.rotation)
    -- add position and update ship values
    s.p1 = utils.addVectors(s.p1, s.position)
    s.p2 = utils.addVectors(s.p2, s.position)
    s.p3 = utils.addVectors(s.p3, s.position)
end

-- draw player ship
function ship.draw( s )
    utils.setColor( s.fill )
    love.graphics.polygon("fill", s.p1.x, s.p1.y, s.p2.x, s.p2.y, s.p3.x, s.p3.y)
end

return ship