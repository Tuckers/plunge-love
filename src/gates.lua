local utils = require "utils"
local color = require "color"
local gates = {}

function gates.draw(x, y, gap, gapPosition, height )
    utils.setColor( color.green )
    love.graphics.rectangle("fill", x, y, gapPosition, height)
    love.graphics.rectangle("fill", gapPosition + gap, y, gapPosition, height)
end

return gates