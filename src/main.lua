local gate = require "gate"
local color = require "color"
local ship = require "ship"
local bar = require "bar"
local collisions = require "collisions"
local bkg = require "background"
require "conf"

-- get current operating system
local os = love.system.getOS( )

-- initial setup
local playerShip = ship.createShip()
local testGate = {}
local playerBar = bar.create()

function love.load()
    gate.resetGate(testGate)
    love.math.setRandomSeed(love.timer.getTime())
    love.mouse.setVisible(false)
end

-- update each interval dt
function love.update(dt)
    -- convert delta time per second into delta frame
    local df = dt / FRAMETIME
    DISTANCE = DISTANCE + FALL_RATE * df
    -- exit on escape
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
    -- adjust velocity and rotation by left input
    if love.keyboard.isDown("right") then
        if playerShip.velocity.x < MAX_VELOCITY then
            playerShip.velocity.x = playerShip.velocity.x + SHIP_ACCELERATION * df
        end
        if playerShip.rotation > -MAX_ROTATION then
            playerShip.rotation = playerShip.rotation - ROTATION_ACCELERATION * df
        end
    end
    -- adjust velocity and rotation by right input
    if love.keyboard.isDown("left") then
        if playerShip.velocity.x > -MAX_VELOCITY then
            playerShip.velocity.x = playerShip.velocity.x - SHIP_ACCELERATION * df
        end
        if playerShip.rotation < MAX_ROTATION then
            playerShip.rotation = playerShip.rotation + ROTATION_ACCELERATION * df
        end
    end
    -- check for collisions
    local collision = false
    if testGate.belowPlayer then
        collision = collisions.checkCollision( playerShip, testGate)
    end

    if collision and testGate.belowPlayer then
        testGate.hit = true
        testGate.belowPlayer = false
        HEAT = HEAT + 1
    end

    if testGate.position.y < playerShip.position.y and testGate.belowPlayer then
        testGate.belowPlayer = false
        SCORE = SCORE + 1
    end
    -- update ship position and rotation, gate and heat bar
    ship.update(playerShip, df)
    gate.update(testGate, df)
    bar.update(playerBar)
    bkg.particles:update(dt)
end

-- draw to screen
function love.draw()
    -- rotate graphics if on linux
    if os == "Linux" then
        love.graphics.translate(0, SCREENWIDTH)
        love.graphics.rotate(-math.pi/2)
    end
    -- draw graphics
    color.set(color.darkestGray)
    love.graphics.rectangle("fill", PLAY_PADDING, PLAY_PADDING, PLAY_WIDTH, PLAY_HEIGHT)
    color.set(color.darkBlue)
    love.graphics.draw(bkg.particles, 0, 500)
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
    color.set(color.white)
    love.graphics.print(string.format("%000000009.0f M", DISTANCE), 450, 96)
    love.graphics.print("Playerbar: "..tostring(playerBar.percentage).."%", 450, 120)
    love.graphics.print("Heat: "..tostring(HEAT), 450, 140)
    ship.draw(playerShip)
    gate.draw(testGate)
    bar.draw(playerBar)
    
end