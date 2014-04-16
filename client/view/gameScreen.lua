
local xshift = 0
local yshift = 0

function gameScreen_init()
    
end


function gameScreen_update(dt)
       
end


function gameScreen_draw()
    
    love.graphics.translate(xshift, yshift)
    
    
    
    love.graphics.draw(imgSuit, player.x, player.y, player.o, 1, 1, 32, 32)
end

function gameScreen_shift(x, y)
    xshift = xshift + x
    yshift = yshift + y
end
