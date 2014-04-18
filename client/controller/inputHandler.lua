
KEY_FORWARD = "w"
KEY_BACK = "s"
KEY_LEFT = "q"
KEY_RIGHT = "e"
KEY_LEFT_ROTATE = "a"
KEY_RIGHT_ROTATE = "d"

local oldMousePos = nil

function inputHandler_update(dt)
    
    if oldMousePos ~= nil then
        
        if love.mouse.isDown( "l" ) then
            local x = love.mouse.getX() - oldMousePos[1]
            local y = love.mouse.getY() - oldMousePos[2]
            gameScreen_shift(x, y)
            oldMousePos = {love.mouse.getX(), love.mouse.getY()}
        else
           oldMousePos = nil 
        end
        
    end
end

function inputHandler_mousepressed( x, y, button )
    if button == "l" then
       -- oldMousePos = {x, y}
    end
end

function inputHandler_mousereleased( x, y, button )
    if button == "l" then
        --oldMousePos = nil
    end
end

function inputHandler_keypressed( key, isrepeat )
    if key == KEY_BACK and player.thrusterFront.ready then
       player.thrusterFront:activate()
    end
    if key == KEY_LEFT and player.thrusterLeft.ready then
       player.thrusterLeft:activate()
    end
    if key == KEY_RIGHT and player.thrusterRight.ready then
       player.thrusterRight:activate()
    end
    if key == KEY_FORWARD and player.thrusterBack.ready then
       player.thrusterBack:activate()
    end
    if key == KEY_LEFT_ROTATE and player.thrusterRotateLeft.ready then
       player.thrusterRotateLeft:activate()
    end
    if key == KEY_RIGHT_ROTATE and player.thrusterRotateRight.ready then
       player.thrusterRotateRight:activate()
    end
end

function inputHandler_keyreleased( key )
    --[[
    if key == "s" then
       player.thrusterFront.active = false
       audioHandler_stopThrust()
    end
    if key == "q" then
       player.thrusterLeft.active = false
    end
    if key == "e" then
       player.thrusterRight.active = false
    end
    if key == "w" then
       player.thrusterBack.active = false
    end
    if key == "a" then
       player.thrusterRotateLeft.active = false
    end
    if key == "d" then
       player.thrusterRotateRight.active = false
    end
    ]]--
end