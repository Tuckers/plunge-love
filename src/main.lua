local gate = require "gate"
local color = require "color"
local ship = require "ship"
local collisions = require "collisions"
require "conf"

-- get current operating system
local os = love.system.getOS( )

-- initial setup
local playerShip = ship.createShip()
local testGate = {}

function love.load()
    gate.resetGate(testGate)
    love.math.setRandomSeed(love.timer.getTime())
    love.mouse.setVisible(false)
end

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
    -- update ship position and rotation
    ship.update(playerShip, df)
    gate.update(testGate, df)

    collisions.checkCollision( playerShip, testGate)
end

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
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
    color.set(color.white)
    love.graphics.print(string.format("%000000009.0f M", DISTANCE), 450, 96)
    ship.draw(playerShip)
    gate.draw(testGate)
end