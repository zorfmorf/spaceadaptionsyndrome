
entities = {}

function gameHandler_init()
    player = Player:new()
    player.x = 300
    player.y = 100
    player.xs = 1
    player.ys = 2
    player.r = 0.05
    player.name = "real"
    player.id = 7
    entities[player.id] = player
    
    for i = 1,6 do
        local spaceman = Player:new()
        spaceman.x = math.random( 1, love.graphics.getWidth() )
        spaceman.y = math.random( 1, love.graphics.getHeight() )
        spaceman.r = math.random(-math.pi / 4, math.pi / 4)
        spaceman.xs = math.random(-50, 50)
        spaceman.ys = math.random(-50, 50)
        spaceman.name = "ai"
        spaceman.id = i
        entities[spaceman.id] = spaceman
    end
end

function gameHandler_update(dt)
    
    for i,entity in pairs(entities) do       
       
        -- update position
        entity.x = entity.x + entity.xs * dt
        entity.y = entity.y + entity.ys * dt
        entity.o = entity.o + entity.r * dt
        
        if entity.o > math.pi * 2 then entity.o = entity.o - math.pi * 2 end
        if entity.o < -math.pi * 2 then entity.o = entity.o + math.pi * 2 end
        
        if entity.x > love.graphics.getWidth() + 100 then entity.x = -100 end
        if entity.x < -100  then entity.x = love.graphics.getWidth() + 100 end
        if entity.y > love.graphics.getHeight() + 100 then entity.y = -100 end
        if entity.y < -100 then entity.y = love.graphics.getHeight() + 100 end
       
        --handle thrusters
        if getmetatable(entity) == Player then
            
            for i,thruster in pairs(entity.thruster) do
                
                if thruster.active then
                    
                    if thruster.rotation == 0 then
                        entity.xs = entity.xs + thruster.power * dt * math.sin(entity.o + thruster.angle)
                        entity.ys = entity.ys - thruster.power * dt * math.cos(entity.o + thruster.angle)
                    else
                        entity.r = entity.r + thruster.power * dt * thruster.rotation
                    end
                    
                end
                
                thruster:update(dt)
                
            end
            
            -- if it is actual player
            if entity.name == "real" then
            
                if love.keyboard.isDown( KEY_FORWARD) and entity.thruster["back"].ready then
                    entity.thruster["back"]:activate()
                end
                
                if love.keyboard.isDown( KEY_BACK) and entity.thruster["front"].ready then
                    entity.thruster["front"]:activate()
                end
                
                if love.keyboard.isDown( KEY_RIGHT) and entity.thruster["left"].ready then
                    entity.thruster["left"]:activate()
                end
                
                if love.keyboard.isDown( KEY_LEFT) and entity.thruster["right"].ready then
                    entity.thruster["right"]:activate()
                end
                
                if love.keyboard.isDown( KEY_LEFT_ROTATE) and entity.thruster["rotateRight"].ready then
                    entity.thruster["rotateRight"]:activate()
                end
                
                if love.keyboard.isDown( KEY_RIGHT_ROTATE) and entity.thruster["rotateLeft"].ready then
                    entity.thruster["rotateLeft"]:activate()
                end
            else
                
                --if not damaged then
                if not entity.damaged then
                
                    -- this one is ai controlled
                    if entity.cd == nil or entity.cd <= 0 then
                       
                        entity.cd = 1

                        local tmp = math.random(1, 6)
                        
                        local index, thruster = nil
                        
                        for k=1,tmp do
                            index, thruster = next(entity.thruster)
                        end

                        if thruster ~= nil then thruster:activate() end
                        
                    else
                       entity.cd = entity.cd - dt 
                    end
                        
                    if entity.r < -math.pi / 8 then
                        entity.thruster["rotateRight"]:activate()
                    end
                    
                    if entity.r > math.pi / 8 then
                        entity.thruster["rotateLeft"]:activate()
                    end
                
                end
                
            end

        end
       
    end
    
    -- collision detection. ineffecient
       
    for i,entity in pairs(entities) do 
        
        for j,other in pairs(entities) do 
            
            if i ~= j and math.abs(entity.x - other.x) < 55 and math.abs(entity.y - other.y) < 55 then
                
                if other.name == "ai" then
                    other.damaged = true
                end
                
                if entity.name == "ai" then
                    entity.damaged = true
                end
            
            end
            
        end
        
    end
    
end