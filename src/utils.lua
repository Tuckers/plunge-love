require "math"
require "conf"

local export = {}

-- convert color from 255 space and set love graphics color
function export.setColor( r, g, b, a )
    a = a or 255
    return love.graphics.setColor(love.math.colorFromBytes(r, g, b, a))
end

-- rotate vector by angle in degrees
function export.rotateVector( vector, angle)
    angle = math.rad(angle)

    local cosres = math.cos(angle)
    local sinres = math.sin(angle)

    local result = {}
    result.x = vector.x * cosres - vector.y * sinres
    result.y = vector.x * sinres + vector.y * cosres

    return result
end
-- add two vectors
function export.addVectors( v1, v2 )
    return Vector(v1.x + v2.x, v1.y + v2.y)
end
-- remap values to new range
function export.remap( value, inputStart, inputEnd, outputStart, outputEnd )
    return (value - inputStart)/(inputEnd - inputStart)*(outputEnd - outputStart) + outputStart
end

local FLT_EPSILON = 1.19209290e-07
-- check two lines for collisions
function export.checkCollisionLines(startPos1, endPos1, startPos2, endPos2)
    local collision = false
    local div = (endPos2.y - startPos2.y)*(endPos1.x - startPos1.x) - (endPos2.x - startPos2.x)*(endPos1.y - startPos1.y)
    if math.abs(div) >= FLT_EPSILON then
        collision = true

        local xi = ((startPos2.x - endPos2.x)*(startPos1.x*endPos1.y - startPos1.y*endPos1.x) - (startPos1.x - endPos1.x)*(startPos2.x*endPos2.y - startPos2.y*endPos2.x))/div
        local yi = ((startPos2.y - endPos2.y)*(startPos1.x*endPos1.y - startPos1.y*endPos1.x) - (startPos1.y - endPos1.y)*(startPos2.x*endPos2.y - startPos2.y*endPos2.x))/div

        if (((math.abs(startPos1.x - endPos1.x) > FLT_EPSILON) and (xi < math.min(startPos1.x, endPos1.x) or (xi > math.max(startPos1.x, endPos1.x)))) or
            ((math.abs(startPos2.x - endPos2.x) > FLT_EPSILON) and (xi < math.min(startPos2.x, endPos2.x) or (xi > math.max(startPos2.x, endPos2.x)))) or
            ((math.abs(startPos1.y - endPos1.y) > FLT_EPSILON) and (yi < math.min(startPos1.y, endPos1.y) or (yi > math.max(startPos1.y, endPos1.y)))) or
            ((math.abs(startPos2.y - endPos2.y) > FLT_EPSILON) and (yi < math.min(startPos2.y, endPos2.y) or (yi > math.max(startPos2.y, endPos2.y))))) then
                collision = false;
        end

        return collision
    end
end

return export

