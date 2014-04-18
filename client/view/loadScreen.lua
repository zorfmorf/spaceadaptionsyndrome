--[[
--
-- The loadscreen is shown while connecting to the server and loading assets
--
]]--

local loadvalue = 0

function loadScreen_init()

end

function loadScreen_update(dt)
    local t = percentage:pop()
    while percentage:peek() do
       t = percentage:pop()
    end
    if t ~= nil then
        loadvalue = t
        print(t)
    end
end

function loadScreen_draw()
    
    love.graphics.setColor(150, 200, 240, 200)
    love.graphics.rectangle("fill", 50, love.graphics:getHeight() / 2 - 20, (love.graphics:getWidth() - 100) * loadvalue, 40 )
    
    love.graphics.setColor(150, 200, 240, 255)
    love.graphics.rectangle("line", 50, love.graphics:getHeight() / 2 - 20, love.graphics:getWidth() - 100, 40 )
    
end
