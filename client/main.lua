require "enet"

local host = nil
local server = nil

local sent = false

function love.load(arg)
    
    -- enable debugger
    --if arg[#arg] == "-debug" then require("mobdebug").start() end
    
    timer = 0
end


-- update
function love.update(dt)
    
    if host == nil then
        host = enet.host_create()
        server = host:connect("localhost:5757")
        print(server)
    end
    
    
    timer = timer + dt * 2
    local event = host:service(0)
    
    if event then
        
        if event.type == "connect" then
            print("Connected to", event.peer)
            event.peer:send("MESSAGE|Hello World!")
        elseif event.type == "receive" then
            print("Got message: ", event.data, event.peer, "---\n")
        else
            print("Something happened at least")
        end
        
    end
    
    if timer > 3 and not sent then
        server:send("MESSAGE|Heyjo motherfucker")
        sent = true
    end
    
end


-- draw
function love.draw()
    for i=0,love.graphics:getWidth() - 1 do
        local h = (love.graphics:getHeight() - 1) / 2
        love.graphics.point(i, h +  math.sin(timer + i * 0.01) * h / 2)
        if i == love.graphics:getWidth() / 2 then
            love.graphics.line(i, 0, i, love.graphics:getHeight() - 1 )
           love.graphics.circle("fill", i, h +  math.sin(timer + i * 0.01) * h / 2, 10, 40) 
        end
    end
end
