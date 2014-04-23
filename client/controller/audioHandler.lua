
local thrust = nil
local song = nil
local lazer = nil

function audioHandler_init()
    
    thrust = {}
    thrust[1] = love.audio.newSource("res/thrust.wav")
    thrust[2] = love.audio.newSource("res/thrust2.wav")
    thrust[3] = love.audio.newSource("res/thrust3.wav")
    thrust[4] = love.audio.newSource("res/thrust4.wav")
    thrust[5] = love.audio.newSource("res/thrust5.wav")
    
    lazer = love.audio.newSource("res/lazer.wav")
    
    song = love.audio.newSource("res/bu-shapes-of-feet.it")
    song:setLooping(true)
    --song:play()
    
end

function audioHandler_update(dt)
    
end


function audioHandler_playThrust()
    --thrust[math.random(1, 5)]:play()
end

function audioHandler_playLazer()
    --lazer:play()
end