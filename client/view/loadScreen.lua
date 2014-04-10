--[[
--
-- The loadscreen is shown while connecting to the server and loading assets
--
]]--

function loadScreen_init()
    
end

function loadScreen_update(dt)
    
end

function loadScreen_draw()
    for i=0,love.graphics:getWidth() - 1 do
        local h = (love.graphics:getHeight() - 1) / 2
        love.graphics.point(i, h +  math.sin(timer + i * 0.01) * h / 2)
        if i == love.graphics:getWidth() / 2 then
            love.graphics.line(i, 0, i, love.graphics:getHeight() - 1 )
           love.graphics.circle("fill", i, h +  math.sin(timer + i * 0.01) * h / 2, 10, 40) 
        end
    end
end
