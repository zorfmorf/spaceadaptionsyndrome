
local xshift = 0
local yshift = 0

local font = nil

local stars = nil

function gameScreen_init()
    font = love.graphics.newFont(100)
    
    stars = {}
    for i=1,3 do
        stars[i] = {}
        for k=1,2 do
            local imgData = love.image.newImageData( love.graphics:getWidth(), love.graphics:getHeight())
            local amount = (love.graphics:getWidth() + love.graphics:getHeight()) / 5
            for j=1,amount do
                local c = {math.random(1, love.graphics:getWidth() - 2), math.random(1, love.graphics:getHeight() - 2)}
                imgData:setPixel(c[1], c[2], 255, 255, 255, 255)
                imgData:setPixel(c[1] - 1, c[2], 255, 255, 255, 150)
                imgData:setPixel(c[1] + 1, c[2], 255, 255, 255, 150)
                imgData:setPixel(c[1], c[2] - 1, 255, 255, 255, 150)
                imgData:setPixel(c[1], c[2] + 1, 255, 255, 255, 150)
            end
            stars[i][k] = {love.graphics.newImage(imgData), -love.graphics:getHeight() * (k - 1)}
        end
    end
    
end


function gameScreen_update(dt)
    
    for i,star in pairs(stars) do
        star[1][2] = star[1][2] + dt * i * 10
        star[2][2] = star[2][2] + dt * i * 10
        
        if star[1][2] > love.graphics:getHeight() then
            star[1][2] = -love.graphics:getHeight()
        end
        
        if star[2][2] > love.graphics:getHeight() then
            star[2][2] = -love.graphics:getHeight()
        end
        
    end
    
end


function gameScreen_draw()
    
    
    if background ~= nil then
        love.graphics.setColor(150, 200, 210, 200)
        love.graphics.draw(background, 0, 0) 
    end
    
    for i=1,table.getn(stars) do
			love.graphics.draw(stars[i][1][1], 0, stars[i][1][2])
			love.graphics.draw(stars[i][2][1], 0, stars[i][2][2])
	end
    
    love.graphics.translate(xshift, yshift)
    love.graphics.setColor(255, 255, 255, 255)
    
    if player.thrusterBack.active then
        love.graphics.draw(imgThrust, player.x, player.y, player.o, 1, 1, 4, -8)
    end
    
    if player.thrusterFront.active then
        love.graphics.draw(imgThrust, player.x, player.y, player.o + math.pi, 1, 1, 4, -8)
    end
    
    if player.thrusterLeft.active then
        love.graphics.draw(imgThrust, player.x, player.y, player.o - math.pi / 2, 1, 1, 4, -8)
    end
    
    if player.thrusterRight.active then
        love.graphics.draw(imgThrust, player.x, player.y, player.o + math.pi / 2, 1, 1, 4, -8)
    end
    
    if player.thrusterRotateLeft.active then
        love.graphics.draw(imgThrust, player.x, player.y, player.o, 1, 1, -16, -8)
    end
    
    if player.thrusterRotateRight.active then
        love.graphics.draw(imgThrust, player.x, player.y, player.o, 1, 1, 24, -8)
    end
    
    if player.x < -50 or player.x > love.graphics:getWidth() + 50 or player.y < 50 or player.y > love.graphics:getHeight() + 50 then
        local x = player.x
        local y = player.y
        y = math.max(0, math.min(y, love.graphics:getHeight()))
        x = math.max(0, math.min(x, love.graphics:getWidth()))
        love.graphics.circle("fill", x, y, 20, 50)
    end
    love.graphics.draw(imgSuit, player.x, player.y, player.o, 1, 1, 32, 32)
    
    love.graphics.origin()
    love.graphics.setFont(font)
    love.graphics.setColor(200, 100, 100, 150)
    local string = "See you at ludum dare"
    love.graphics.print(string, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, 0, 1, 1, font:getWidth(string) / 2, font:getHeight())
    
end

function gameScreen_shift(x, y)
    xshift = xshift + x
    yshift = yshift + y
end
