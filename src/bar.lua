local utils = require "utils"
local color = require "color"
require "conf"

local export = {}

function export.setupBar( bar )
    bar = bar or {}
    bar.position = Vector(48, 1805)
    bar.width = 320
    bar.height = 24
    bar.percentage = 100
    bar.color = color.mint
    return bar
end

function export.update( bar, df )
    bar.percentage = bar.percentage - ( HEAT_DAMAGE * HEAT * df )
    if bar.percentage <= 50 then
        bar.color = color.yellow
    end
    if bar.percentage <= 25 then
        bar.color = color.red
    end
end

function export.drawBar( bar )
    utils.setColor(bar.color)
    love.graphics.rectangle()
end

return export