require "enet"
require "view/loadScreen"
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
    
end


-- update
function love.update(dt)
    
    timer = timer + dt * 2
    
    if state == "connecting" or state == "connected" then
        loadScreen_update(dt)
        netHandler_service()
    end
    
    if state == "ingame" then
       gameScreen_update(dt) 
    end
        
end


-- draw
function love.draw()
    
    if state == "ingame" then
        
        gameScreen_draw()
        
    else
        
        loadScreen_draw()
        
    end
    
end
