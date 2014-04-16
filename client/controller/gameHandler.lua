
entities = {}

function gameHandler_init()
    player = Player:new()
    player.xs = 5
    player.ys = 10
    player.r = 0.1
    table.insert(entities, player)
end

function gameHandler_update(dt)
    
    for i,entity in pairs(entities) do
       
        -- update position
        entity.x = entity.x + entity.xs * dt
        entity.y = entity.y + entity.ys * dt
        entity.o = entity.o + entity.r * dt
       
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
                      
        end
       
    end
    
end


      --     thrusterFront = Thruster:new(2, 1),
  --  thrusterLeft = Thruster:new(2, 1),
  --  thrusterRight = Thruster:new(2, 1),
  --  thrusterBack = Thruster:new(5, 3),