local export = {}

-- set current graphics color, with optional alpha
function export.set( color, a)
    a = a or color.a
    if a > 1 then
        a = a / 100
    end
    love.graphics.setColor( color.r, color.g, color.b, a )
end

-- color constructor
function Color( r, g, b, a )
    local color = {}
    color.r = r / 255
    color.g = g / 255
    color.b = b / 255
    color.a = a / 100
    return color
end

-- basics
export.green = Color( 0, 255, 0, 100 )
export.white = Color( 255, 255, 255, 100 )
export.blue = Color( 0, 0, 255, 100 )
export.black = Color( 0, 0, 0, 100 )
export.purple = Color( 188, 42, 239, 100 )

-- game
export.darkestGray = Color( 8, 8, 8, 100 )
export.mint = Color( 27, 246, 141, 100 )
export.darkMint = Color( 39, 170, 107, 100 )
export.darkBlue = Color( 4, 34, 69, 100 )
export.warning = Color( 246, 211, 17, 100 )
export.danger = Color( 252, 99, 65, 100 )

return export