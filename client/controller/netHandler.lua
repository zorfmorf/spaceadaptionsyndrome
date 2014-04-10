
local host = nil
local server = nil
local sent = false
local target = "localhost:5757"

function netHandler_service()
    
    local event = host:service(0)
    
     if event then
         
         print(event.type)
        
        if event.type == "connect" then
            
            print("Connected to", event.peer)
            event.peer:send("MESSAGE|Hello World!")
            stateHandler_connected()
            
        elseif event.type == "recieve" then
            
            print("Got message: ", event.data, event.peer, "---\n")
            
        else
            
            print("Something happened at least")
            
        end
        
    end
end

function netHandler_connect()
    if host == nil then
        host = enet.host_create()
        server = host:connect(target)
    end
end

function netHandler_getStatus()
    
end
