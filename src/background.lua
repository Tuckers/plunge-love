local color = require "color"
require "conf"

local export = {}

function export.draw( bkg )
    love.graphics.rectangle()
end

local image = love.graphics.newImage( "assets/lineGradient.png" )
image:setFilter("linear", "linear")

local particles = love.graphics.newParticleSystem(image, 412)
particles:setColors(1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0.5, 1, 1, 1, 0)
particles:setDirection(-1.5707963705063)
particles:setEmissionArea("normal", 675.25518798828, 100, 0, false)
particles:setEmissionRate(55.444149017334)
particles:setEmitterLifetime(-1)
particles:setInsertMode("top")
particles:setLinearAcceleration(0.45932897925377, -875.83825683594, 0, -1322.9184570313)
particles:setLinearDamping(-0.0018373158527538, 0)
particles:setOffset(100, 2)
particles:setParticleLifetime(0.20006328821182, 7.0657453536987)
particles:setRadialAcceleration(0, 0)
particles:setRelativeRotation(false)
particles:setRotation(-1.5707963705063, -1.5707963705063)
particles:setSizes(0.40000000596046)
particles:setSizeVariation(0)
particles:setSpeed(0.020414620637894, 102.91010284424)
particles:setSpin(0, 0)
particles:setSpinVariation(0)
particles:setSpread(0)
particles:setTangentialAcceleration(0, 0)

export.particles = particles

return export
