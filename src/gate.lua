local utils = require "utils"
local color = require "color"
require "conf"

local gate = {}

function gate.createGate()
    local newGate = {
        x = 0,
        y = 0,
        gap = love.math.random(80, 200),
        gapPosition = love.math.random(0, 1000),
        height = 5
    }
    return newGate
end

function gate.draw(x, y, gap, gapPosition, height )
    utils.setColor( color.green )
    love.graphics.rectangle("fill", x, y, gapPosition, height)
    love.graphics.rectangle("fill", gapPosition + gap, y, gapPosition, height)
end

return gate