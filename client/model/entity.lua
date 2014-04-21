
-- a suit has a set of thrusters powering it
Thruster = class 
{
    power = 1, -- thrust/s
    usage = 1, -- energy/s
    state = "intact",
    active = false,
    ta = 0, -- time active
    tt = 0.3, -- max time active
    ready = true,
    angle = 0,
    rotation = 0
}
function Thruster:__init(power, usage, angle, rotation)
    self.power = power
    self.usage = usage
    self.angle = angle
    self.rotation = rotation
end
function Thruster:activate()
    if self.ready then
        self.active = true
        self.ready = false
        audioHandler_playThrust()
    end
end
function Thruster:update(dt)
    if not self.ready then
        self.ta = self.ta + dt
        if self.ta >= self.tt then
            self.active = false
        end
        if self.ta >= self.tt * 2 then
            self.ta = 0
            self.ready = true
        end
    end
end
Thruster.name = "Thruster"


-- a weapon
Weapon = class {
    particles = nil,
    cooldown = 0
}
function Weapon:__init()
    self.particles = love.graphics.newParticleSystem(imgCloud, 4000)
    self.particles:setColors(0, 176, 255, 100, 146, 255, 0, 155)
    self.particles:setEmissionRate(10000)
    self.particles:setEmitterLifetime(0.2)
    self.particles:setParticleLifetime(0.2, 0.2)
    self.particles:setSizeVariation(1)
    self.particles:setSizes(0.2, 0.4, 0.6)
    self.particles:setSpeed(1000, 12000)
    self.particles:setSpread(0)
    self.particles:setSpin(-1, 1)
    self.particles:setSpinVariation(1)
    self.particles:setAreaSpread("none", 0, 0)
    self.particles:pause()
    self.particles:moveTo(player.x, player.y)
    self.particles:setDirection(player.o - math.pi / 2)
    
end
function Weapon:fire()
    
    if self.cooldown <= 0 then
        self.cooldown = 0.5
        self.particles:moveTo(player.x, player.y)
        self.particles:setDirection(player.o - math.pi / 2)
        self.particles:reset()
        self.particles:start()
    end
    
end
function Weapon:update(dt)
    self.particles:update(dt)
    if self.cooldown > 0 then
        self.cooldown = self.cooldown - dt
    end
end
Weapon.name = "Weapon"



-- everything flying around in space is an entity
Entity = class 
{
    x = 0,
    y = 0,
    xs = 0,
    ys = 0,
    o = 0,
    r = 0,
    damaged = false
}
Entity.name = "Entity"


-- players fly around in spacesuits and shoot at each other
Player = Entity:extends()
function Player:__init()
    self.thruster = {}
    self.thruster["front"] = Thruster:new(40, 1, math.pi, 0)
    self.thruster["left"] = Thruster:new(40, 1, math.pi / 2, 0)
    self.thruster["right"] = Thruster:new(40, 1, -math.pi / 2, 0)
    self.thruster["back"] = Thruster:new(40, 1, 0, 0)
    self.thruster["rotateLeft"] = Thruster:new(2, 0.1, 0, -1)
    self.thruster["rotateRight"] = Thruster:new(2, 0.1, 0, 1)
end