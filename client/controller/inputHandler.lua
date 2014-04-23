
KEY_FORWARD = "w"
KEY_BACK = "s"
KEY_LEFT = "q"
KEY_RIGHT = "e"
KEY_LEFT_ROTATE = "d"
KEY_RIGHT_ROTATE = "a"

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
    if key == KEY_BACK and player.thruster["front"].ready then
       player.thruster["front"]:activate()
    end
    if key == KEY_LEFT and player.thruster["right"].ready then
       player.thruster["right"]:activate()
    end
    if key == KEY_RIGHT and player.thruster["left"].ready then
       player.thruster["left"]:activate()
    end
    if key == KEY_FORWARD and player.thruster["back"].ready then
       player.thruster["back"]:activate()
    end
    if key == KEY_LEFT_ROTATE and player.thruster["rotateRight"].ready then
       player.thruster["rotateRight"]:activate()
    end
    if key == KEY_RIGHT_ROTATE and player.thruster["rotateLeft"].ready then
       player.thruster["rotateLeft"]:activate()
    end
    
    if key == " " then
        gameHandler_playerFireWeapon()
    end
end

function inputHandler_keyreleased( key )
    
end