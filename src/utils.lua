require "math"

local utils = {}

-- convert color from 255 space and set love graphics color
function utils.setColor( r, g, b, a )
    a = a or 255
    return love.graphics.setColor(love.math.colorFromBytes(r, g, b, a))
end

-- rotate vector by angle in degrees
function utils.rotateVector( vector, angle)
    angle = math.rad(angle)

    local cosres = math.cos(angle)
    local sinres = math.sin(angle)

    local result = {}
    result.x = vector.x * cosres - vector.y * sinres
    result.y = vector.x * sinres + vector.y * cosres

    return result
end

-- add two vectors
function utils.addVectors( v1, v2 )
    return { x = v1.x + v2.x, y = v1.y + v2.y }
end

return utils