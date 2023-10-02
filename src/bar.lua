local color = require "color"
require "conf"

local export = {}

function export.create( bar )
    bar = bar or {}
    bar.position = Vector(48, 1805)
    bar.width = 320
    bar.height = 24
    bar.percentage = 100
    bar.color = color.mint
    return bar
end

function export.update( bar )
    bar.percentage = 100 - ( HEAT_DAMAGE * HEAT )
    if bar.percentage <= 50 then
        bar.color = color.warning
    end
    if bar.percentage <= 25 then
        bar.color = color.danger
    end
end

function export.draw( bar )
    -- draw bar background
    color.set( bar.color, 20 )
    love.graphics.rectangle("fill", bar.position.x, bar.position.y, bar.width, bar.height)
    -- draw bar fill
    color.set( bar.color )
    love.graphics.rectangle("fill", bar.position.x, bar.position.y, ( bar.width / 100 ) * bar.percentage, bar.height)
end

return export