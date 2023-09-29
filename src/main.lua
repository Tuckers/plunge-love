function love.load()
    player = {}
    player.x = 400
    player.y = 200
    player.velocity = 0
end

function love.update(dt)
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
    if love.keyboard.isDown("left") then
        player.velocity = player.velocity - 1
    end
    if love.keyboard.isDown("right") then
        player.velocity = player.velocity + 1
    end
    player.x = player.x + player.velocity
end

function love.draw()
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
    setColor(255, 0, 0)
    love.graphics.polygon("fill", player.x - 50, player.y - 50, player.x, player.y + 50, player.x + 50, player.y - 50)
end

function setColor( r, g, b, a )
    a = a or 255
    return love.graphics.setColor(love.math.colorFromBytes(r, g, b, a))
end