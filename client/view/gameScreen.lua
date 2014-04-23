
local xshift = 0
local yshift = 0

local font = nil

local stars = nil

local opacity = 0

message = nil --global message

function gameScreen_init()
    font = love.graphics.newFont(100)
    fontSmall = love.graphics.newFont(20)
    fontKill = love.graphics.newFont(40)
    
    stars = {}
    for i=1,4 do
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
        star[1][2] = star[1][2] + dt * (i - 1) * 50 * (i - 1)
        star[2][2] = star[2][2] + dt * (i - 1) * 50 * (i - 1)
        
        if star[1][2] > love.graphics:getHeight() then
            star[1][2] = -love.graphics:getHeight()
        end
        
        if star[2][2] > love.graphics:getHeight() then
            star[2][2] = -love.graphics:getHeight()
        end
        
    end
    
    if state == "gameover" then
       opacity = math.min(255, opacity + 25 *dt) 
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
    
    if state == "ingame" then
    
        for i,cand in pairs(entities) do
            
            if cand.thruster["back"].active then
                love.graphics.draw(imgThrust, cand.x, cand.y, cand.o, 1, 1, 4, -8)
            end
            
            if cand.thruster["front"].active then
                love.graphics.draw(imgThrust, cand.x, cand.y, cand.o + math.pi, 1, 1, 4, -8)
            end
            
            if cand.thruster["right"].active then
                love.graphics.draw(imgThrust, cand.x, cand.y, cand.o - math.pi / 2, 1, 1, 4, -8)
            end
            
            if cand.thruster["left"].active then
                love.graphics.draw(imgThrust, cand.x, cand.y, cand.o + math.pi / 2, 1, 1, 4, -8)
            end
            
            if cand.thruster["rotateLeft"].active then
                love.graphics.draw(imgThrust, cand.x, cand.y, cand.o + math.pi / 3, 1, 1, -16, 0)
            end
            
            if cand.thruster["rotateRight"].active then
                love.graphics.draw(imgThrust, cand.x, cand.y, cand.o - math.pi / 3, 1, 1, 24, 0)
            end
            
            if cand.name == "real" then
                
                love.graphics.setBlendMode( "additive" )
                love.graphics.draw(player.weapon.particles, 0, 0)
                love.graphics.setBlendMode( "alpha" )
                
                love.graphics.draw(imgSuit, cand.x, cand.y, cand.o, 1, 1, 32, 32)
            else
                if cand.damaged then
                    love.graphics.draw(imgSuitAi_dmg, cand.x, cand.y, cand.o, 1, 1, 32, 32)
                else
                    love.graphics.draw(imgSuitAi, cand.x, cand.y, cand.o, 1, 1, 32, 32)
                end
            end
            
        end
    end
    
    
    love.graphics.origin()
    
    if state == "gameover" then
        love.graphics.setColor(0, 0, 0, opacity)
        love.graphics.rectangle("fill", 0, 0, love.graphics:getWidth(), love.graphics:getHeight())
    end
    
    love.graphics.setFont(font)
    love.graphics.setColor(200, 100, 100, 190)
    local string = math.floor(timeLeft * 10) * 0.1 --"Stay on the screen!"
    
    if message ~= nil then string = message end
    if state == "gameover" then string = "Game Over: "..math.floor(clock) end
    
    love.graphics.print(string, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, 0, 1, 1, font:getWidth(string) / 2, font:getHeight())
    
    love.graphics.setFont(fontKill)
    love.graphics.print(killcounter .. " kills", love.graphics.getWidth() - 200, 10)
    
    love.graphics.setFont(fontSmall)
    love.graphics.setColor(255, 255, 255, 255)
    --love.graphics.print(love.timer.getFPS(), love.graphics.getWidth() - 60, 10)
    
end

function gameScreen_shift(x, y)
    xshift = xshift + x
    yshift = yshift + y
end
