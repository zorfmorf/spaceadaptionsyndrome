
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
            
            if entity.thrusterRotateLeft.active then
                entity.r = entity.r - entity.thrusterRotateLeft.power * dt
            end
           
            if entity.thrusterRotateRight.active then
                entity.r = entity.r + entity.thrusterRotateRight.power * dt
            end
            
            if entity.thrusterFront.active then
                entity.xs = entity.xs + entity.thrusterFront.power * dt * math.sin(entity.o - math.pi)
                entity.ys = entity.ys - entity.thrusterFront.power * dt * math.cos(entity.o  - math.pi)
            end
            
            if entity.thrusterBack.active then
                entity.xs = entity.xs + entity.thrusterBack.power * dt * math.sin(entity.o)
                entity.ys = entity.ys - entity.thrusterBack.power * dt * math.cos(entity.o)
            end
            
            if entity.thrusterLeft.active then
                entity.xs = entity.xs + entity.thrusterLeft.power * dt * math.sin(entity.o - math.pi / 2)
                entity.ys = entity.ys - entity.thrusterLeft.power * dt * math.cos(entity.o - math.pi / 2)
            end
            
            if entity.thrusterRight.active then
                entity.xs = entity.xs + entity.thrusterRight.power * dt * math.sin(entity.o + math.pi / 2)
                entity.ys = entity.ys - entity.thrusterRight.power * dt * math.cos(entity.o + math.pi / 2)
            end
            
            entity.thrusterRotateLeft:update(dt)
            entity.thrusterRotateRight:update(dt)
            entity.thrusterFront:update(dt)
            entity.thrusterBack:update(dt)
            entity.thrusterLeft:update(dt)
            entity.thrusterRight:update(dt)
            
            
            if entity.name == "real" then
            
                if love.keyboard.isDown( KEY_FORWARD) and entity.thrusterBack.ready then
                    entity.thrusterBack:activate()
                end
                
                if love.keyboard.isDown( KEY_BACK) and entity.thrusterFront.ready then
                    entity.thrusterFront:activate()
                end
                
                if love.keyboard.isDown( KEY_RIGHT) and entity.thrusterRight.ready then
                    entity.thrusterRight:activate()
                end
                
                if love.keyboard.isDown( KEY_LEFT) and entity.thrusterLeft.ready then
                    entity.thrusterLeft:activate()
                end
                
                if love.keyboard.isDown( KEY_LEFT_ROTATE) and entity.thrusterRotateLeft.ready then
                    entity.thrusterRotateLeft:activate()
                end
                
                if love.keyboard.isDown( KEY_RIGHT_ROTATE) and entity.thrusterRotateRight.ready then
                    entity.thrusterRotateRight:activate()
                end
            else
                
                --if not damaged then
                if not entity.damaged then
                
                    -- this one is ai controlled
                    if entity.cd == nil or entity.cd <= 0 then
                       
                       entity.cd = 1
                       
                       local tmp = math.random(1, 6)
                       
                       if tmp == 1 then entity.thrusterBack:activate() end
                       if tmp == 2 then entity.thrusterFront:activate() end
                       if tmp == 3 then entity.thrusterRight:activate() end
                       if tmp == 4 then entity.thrusterLeft:activate() end
                       if tmp == 5 then entity.thrusterRotateLeft:activate() end
                       if tmp == 6 then entity.thrusterRotateRight:activate() end
                        
                    else
                       entity.cd = entity.cd - dt 
                    end
                        
                    if entity.r < -math.pi / 8 then
                        entity.thrusterRotateRight:activate()
                    end
                    
                    if entity.r > math.pi / 8 then
                        entity.thrusterRotateLeft:activate()
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