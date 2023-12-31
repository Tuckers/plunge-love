function love.conf(t)
    t.window.width = 1920
    t.window.height = 1080
    t.window.fullscreen = true
    t.window.title = "Plunge"
    t.modules.joystick = false
    t.window.vsync = 1
end

-- make vector
function Vector( x, y )
    return { x = x, y = y }
end

-- layout
SCREENWIDTH = 1080
SCREENHEIGHT = 1920
SHIPWIDTH = 36
SHIPHEIGHT = 48
PLAY_WIDTH = 984
PLAY_HEIGHT = 1718
PLAY_PADDING = 48
SHIP_POSITION_Y = 340
TEXT_SIZE_L = 36
TEXT_SIZE_M = 24
TEXT_SIZE_S = 16
MAX_GATE_HEIGHT = 128
MIN_GATE_HEIGHT = 4

-- physics
INERTIA = 0.1
ROTATION_INERTIA = 0.1
MAX_VELOCITY = 100.0
FALL_RATE = 5
MAX_GATE_SPEED = 10
GATE_ACCELERATION = 0.1
MAX_ROTATION = 30
ROTATION_ACCELERATION = 1
SHIP_ACCELERATION = 1

-- gamelogic
MAX_GATES = 10
MAX_LINES = 10
SCORE = 0
DISTANCE = 0
FRAMERATE = 60
FRAMETIME = 1 / FRAMERATE
HEAT = 0
HEAT_DAMAGE = 25