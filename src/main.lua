local gates = require "gates"
local utils = require "utils"
local color = require "color"

function love.load()
    Player = {}
    Player.x = 400
    Player.y = 200
    Player.velocity = 0
end

function love.update(dt)
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
    if love.keyboard.isDown("left") then
        Player.velocity = Player.velocity - 1
    end
    if love.keyboard.isDown("right") then
        Player.velocity = Player.velocity + 1
    end
    Player.x = Player.x + Player.velocity
end

function love.draw()
    utils.setColor( color.green )
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
    utils.setColor( color.red )
    love.graphics.polygon("fill", Player.x - 50, Player.y - 50, Player.x, Player.y + 50, Player.x + 50, Player.y - 50)
end