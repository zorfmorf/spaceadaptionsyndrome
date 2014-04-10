
state = nil


function stateHandler_init()
    state = "connecting"
end


function stateHandler_connected()
    state = "connected"
end


function stateHandler_ready()
    state = "ingame"
end
