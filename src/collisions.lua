local utils = require "utils"
require "conf"
local export = {}

function export.checkCollision( ship, gate )
    local topOfGate = gate.position.y + gate.height / 2
    local leftCheck = utils.checkCollisionLines(ship.p1, ship.p2, Vector(PLAY_PADDING, topOfGate), Vector(gate.gapPosition, topOfGate))
    local rightCheck = utils.checkCollisionLines(ship.p3, ship.p2, Vector(gate.gapPosition + gate.gap, topOfGate), Vector(PLAY_WIDTH + PLAY_PADDING, topOfGate))
    local collision = leftCheck or rightCheck

    if collision and gate.belowPlayer then
        gate.hit = true
        gate.belowPlayer = false
        SCORE = SCORE - 1
    end

    if gate.position.y < ship.position.y and gate.belowPlayer then
        gate.belowPlayer = false
        SCORE = SCORE + 1
    end
end

return export