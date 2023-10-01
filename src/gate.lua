local utils = require "utils"
local color = require "color"
require "conf"

local export = {}

function export.resetGate( gate )
    gate.position = {x = PLAY_PADDING, y = PLAY_HEIGHT + PLAY_PADDING }
    gate.velocity = {x = 0, y = 1}
    gate.height = 5
    gate.gap = love.math.random(80, 200)
    gate.gapPosition = love.math.random(0, 1000)
    gate.gapPercentage = 0
    gate.belowPlayer = true
    gate.hit = false
    gate.color = color.white
end

function export.update ( gate, df )
    -- get distance to bottom of playarea
    local absY = PLAY_HEIGHT + PLAY_PADDING - gate.position.y

    -- gate phases
    if absY < 128 then
        gate.height = gate.height + 1 * df
    elseif absY >= 128 and absY < 400 then
        gate.height = utils.remap( absY, MAX_GATE_HEIGHT, 400, MAX_GATE_HEIGHT, MIN_GATE_HEIGHT ) * df
    elseif absY >= 400 then
        gate.height = MIN_GATE_HEIGHT
        if gate.gapPercentage < 100 then
            gate.gapPercentage = utils.remap(absY, 400, 800, 0, 100) * df
        end
        if gate.velocity.y < MAX_GATE_SPEED then
            gate.velocity.y = gate.velocity.y + GATE_ACCELERATION * df
        end
    end
    if absY > PLAY_HEIGHT then
        export.resetGate( gate )
    end
    gate.position.y = gate.position.y - gate.velocity.y
end

function export.draw( gate )
    local gateColor = gate.hit and color.danger or gate.color
    local gapCenter = gate.gap / 2 + gate.gapPosition
    local opening = gate.gap / 100 * gate.gapPercentage
    local gapStart = gapCenter - opening / 2
    local gapEnd = gapCenter + opening / 2
    if gate.gapPercentage > 1 and gate.gapPercentage < 100 then
        color.set( color.white )
        love.graphics.rectangle("fill", gapStart, gate.position.y, opening, gate.height)
    end
    color.set( gateColor )
    love.graphics.rectangle("fill", gate.position.x, gate.position.y, gapStart - PLAY_PADDING, gate.height)
    love.graphics.rectangle("fill", gapEnd, gate.position.y, PLAY_WIDTH - gapEnd + PLAY_PADDING, gate.height)
end

return export