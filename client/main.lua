class = require "misc/30logclean"
require "enet"

require "view/gameScreen"
require "view/loadScreen"

require "model/ressourceLoader"
require "model/entity"

require "controller/audioHandler"
require "controller/gameHandler"
require "controller/inputHandler"
require "controller/netHandler"
require "controller/stateHandler"

function love.load(arg)
    
    -- enable debugger
    --if arg[#arg] == "-debug" then require("mobdebug").start() end
    
    timer = 0
    stateHandler_init()
    netHandler_connect()
    loadScreen_init()
    gameScreen_init()
    
    -- load all ressources
    load_Images()
    audioHandler_init()
    
    -- game
    gameHandler_init()
    
    --stateHandler_ready() -- for testing purposes
    
    -- temporary thread channels
    output = love.thread.getChannel("nebulator_output")
    percentage = love.thread.getChannel("nebulator_percentage")
    input = love.thread.getChannel("nebulator_input")
    
    input:push(love.graphics:getWidth())
    input:push(love.graphics:getHeight())
    input:push(math.random(1, 100000))
    
    thread = love.thread.newThread('misc/nebulator.lua')
    thread:start()
    
end


-- update
function love.update(dt)
    
    timer = timer + dt * 2
    
    if state == "connecting" or state == "connected" then
        loadScreen_update(dt)
        netHandler_service()
        
        local tmp = output:pop()
        if tmp ~= nil then
            background = love.graphics.newImage(tmp)
            stateHandler_ready()
        end
    end
    
    if state == "ingame" then
        gameHandler_update(dt)
        inputHandler_update(dt)
        gameScreen_update(dt) 
    end
    
    if state == "gameover" then
        gameScreen_update(dt)
    end
        
end


-- draw
function love.draw()
    
    if state == "ingame" or state == "gameover"  then
        
        gameScreen_draw()
        
    else
        
        loadScreen_draw()
        
    end
    
end

-- redirect key input to inputHandler
function love.mousepressed( x, y, button )
    inputHandler_mousepressed( x, y, button )
end

function love.mousereleased( x, y, button )
    inputHandler_mousereleased( x, y, button )
end

function love.keypressed( key, isrepeat )
    if key == "escape" then love.event.quit() end
    inputHandler_keypressed( key, isrepeat )
end

function love.keyreleased( key )
    inputHandler_keyreleased( key )
end
