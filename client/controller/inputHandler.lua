
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
    if key == "s" then
       player.thrusterFront.active = true
    end
    if key == "q" then
       player.thrusterLeft.active = true
    end
    if key == "e" then
       player.thrusterRight.active = true
    end
    if key == "w" then
       player.thrusterBack.active = true
    end
    if key == "a" then
       player.thrusterRotateLeft.active = true
    end
    if key == "d" then
       player.thrusterRotateRight.active = true
    end
end

function inputHandler_keyreleased( key )
    if key == "s" then
       player.thrusterFront.active = false
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
end