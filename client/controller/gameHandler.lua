
entities = {}

killcounter = 0

message = nil -- messages are displayed globally to the player

--spawn in enemy from side
function gameHandler_spawnEnemy(id)
    local spaceman = Player:new()
    
    spaceman.x = math.random( 1, love.graphics.getWidth() )
    spaceman.y = math.random( -100, -50 )
    spaceman.r = math.random(-math.pi / 4, math.pi / 4)
    spaceman.xs = math.random(-50, 50)
    spaceman.ys = math.random(-50, 50)
    spaceman.name = "ai"
    spaceman.id = id
    entities[spaceman.id] = spaceman 
end

-- call once on startup
function gameHandler_init()
    player = Player:new()
    player.x = love.graphics:getWidth() / 2
    player.y = love.graphics:getHeight() * 0.7
    player.xs = 1
    player.ys = 2
    player.r = 0.05
    player.name = "real"
    player.weapon = Weapon:new()
    player.id = 7
    entities[player.id] = player
    
    for i = 1,6 do
        gameHandler_spawnEnemy(i)
    end
end

function gameHandler_playerFireWeapon()
    
    if player.weapon:fire() then
        
        audioHandler_playLazer()
    
        -- collision detection.
        -- Not sooo inefficient as we only use it once per shot. so should be okay even for large enemy amounts
        
        local count = 0
        
        for i,cand in pairs(entities) do
            
            if cand.name == "ai" then
                -- first calculate angle to target
                local angle = player.o - (math.atan2(cand.y - player.y, cand.x - player.x) + math.pi / 2)
                
                --calc distance between player and target
                local dist = math.sqrt( math.pow(player.x - cand.x, 2) + math.pow(player.y - cand.y, 2) )
                
                --one angle is 90° anyway so the last has to be wait we are using radian!!
                local angle2 = math.pi / 2 - angle
                
                -- using law of sines we can find out the distance between circle and collision point
                local lengthDC = math.sin(angle) * dist
                
                if math.abs(lengthDC) <= 40 and not cand.damaged then

                    cand.damaged = true
                    count = count + 1
                    
                end
                
            end
        end
        
        if count == 1 then message = "HIT!" end
        if count == 2 then message = "DOUBLE KILL!" end
        if count >= 3 then message = "RIDICULOUS" end
        
    end
    
end

function gameHandler_checkDespawn(entity)
    
    if entity.name == "ai" and entity.damaged then
        
        entities[entity.id] = nil
        gameHandler_spawnEnemy(entity.id)
        
    end
    
    if entity.name == "real" then
        stateHandler_gameOver()
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
        
        --adjust position if out of screen (come in on the other side)
        if entity.x > love.graphics.getWidth() + 100 then entity.x = -100 gameHandler_checkDespawn(entity) end
        if entity.x < -100  then entity.x = love.graphics.getWidth() + 100 gameHandler_checkDespawn(entity) end
        if entity.y > love.graphics.getHeight() + 100 then entity.y = -100 gameHandler_checkDespawn(entity) end
        if entity.y < -100 then entity.y = love.graphics.getHeight() + 100 gameHandler_checkDespawn(entity) end
       
        --handle thrusters
        if getmetatable(entity) == Player then
            
            if entity.weapon ~= nil then
                
                entity.weapon:update(dt, entity.x, entity.y, entity.o)
                
            end
            
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
    
end