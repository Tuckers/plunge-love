local utils = {}

function utils.setColor( r, g, b, a )
    a = a or 255
    return love.graphics.setColor(love.math.colorFromBytes(r, g, b, a))
end

return utils