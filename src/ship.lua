local utils = require "utils"
local color = require "color"
require "conf"

local export = {}

-- helpful for shape stuff
local halfWidth = SHIPWIDTH / 2
local halfHeight = SHIPHEIGHT / 2

-- create new player ship
function export.createShip()
    local ship = {}
    ship.position = Vector( SCREENWIDTH / 2, SHIP_POSITION_Y )
    ship.velocity = Vector( 0, 0)
    ship.rotation = 0
    ship.fill = color.mint
    ship.p1 = Vector( -halfWidth, -halfHeight )
    ship.p2 = Vector( 0, halfHeight )
    ship.p3 = Vector( halfWidth, -halfHeight )
    return ship
end

-- update player ship values
function export.update( ship, df )
    -- apply inertia
    if ship.velocity.x > 0.1 then
        ship.velocity.x = ship.velocity.x - INERTIA * df
    elseif ship.velocity.x < -0.1 then
        ship.velocity.x = ship.velocity.x + INERTIA * df
    end
    -- apply rotation inertia
    if ship.rotation > 0.1 then
        ship.rotation = ship.rotation - ROTATION_INERTIA * df
    elseif ship.rotation < -0.1 then
        ship.rotation = ship.rotation + ROTATION_INERTIA * df
    end
    -- add velocity to position
    ship.position.x = ship.position.x + ship.velocity.x
    -- check for out of bounds
    if ship.position.x < PLAY_PADDING + SHIPWIDTH / 2 then
        ship.position.x = PLAY_PADDING + SHIPWIDTH / 2
    elseif ship.position.x > PLAY_WIDTH + PLAY_PADDING - SHIPWIDTH / 2 then
        ship.position.x = PLAY_WIDTH + PLAY_PADDING - SHIPWIDTH / 2
    end
    -- rotate triangle points
    ship.p1 = utils.rotateVector({x = -halfWidth, y = -halfHeight}, ship.rotation)
    ship.p2 = utils.rotateVector({x = 0, y = halfHeight}, ship.rotation)
    ship.p3 = utils.rotateVector({x = halfWidth, y = -halfHeight}, ship.rotation)
    -- add position and update ship values
    ship.p1 = utils.addVectors(ship.p1, ship.position)
    ship.p2 = utils.addVectors(ship.p2, ship.position)
    ship.p3 = utils.addVectors(ship.p3, ship.position)
end

-- draw player ship
function export.draw( ship )
    utils.setColor( ship.fill )
    love.graphics.polygon("fill", ship.p1.x, ship.p1.y, ship.p2.x, ship.p2.y, ship.p3.x, ship.p3.y)
end

return export