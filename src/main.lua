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
local playerBar = bar.create()
local gates = {}

local font36 = love.graphics.newFont(36, "mono")
font36:setFilter("nearest")
local font24 = love.graphics.newFont(24, "mono")
font24:setFilter("nearest")

function love.load()
    gates[1] = gate.create()
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
    for i = 1, #gates , 1 do
        local collision = false
        if gates[i].belowPlayer then
            collision = collisions.checkCollision( playerShip, gates[i])
        end
        if collision and gates[i].belowPlayer then
            gates[i].hit = true
            gates[i].belowPlayer = false
            HEAT = HEAT + 1
        end
        if gates[i].position.y < playerShip.position.y and gates[i].belowPlayer then
            gates[i].belowPlayer = false
            SCORE = SCORE + 1
        end
        gate.update(gates[i], df)
    end
    -- update ship position and rotation, gate and heat bar
    ship.update(playerShip, df)
    bar.update(playerBar)
    bkg.particles:update(dt)
    -- logic to add and remove gates... maybe?
    if #gates < MAX_GATES and gates[1].position.y < (PLAY_PADDING + PLAY_HEIGHT - 130) then
        table.insert(gates, 1, gate.create())
    end
    if gates[#gates].position.y < PLAY_PADDING then
        table.remove(gates)
    end
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
    love.graphics.setFont(font36)
    love.graphics.print(string.format("%09.0f M", DISTANCE), 450, 96)
    love.graphics.setFont(font24)
    love.graphics.print(string.format("%07.0f", SCORE.."00"), 48, 1845)
    ship.draw(playerShip)
    for i = 1, #gates , 1 do
        gate.draw(gates[i])
    end
    bar.draw(playerBar)
    
end