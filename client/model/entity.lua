
-- a suit has a set of thrusters powering it
Thruster = class 
{
    power = 1, -- thrust/s
    usage = 1, -- energy/s
    state = "intact",
    active = false,
    ta = 0, -- time active
    tt = 0.3, -- max time active
    ready = true
}
function Thruster:__init(power, usage)
    self.power = power
    self.usage = usage
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


-- everything flying around in space is an entity
Entity = class 
{
    x = 0,
    y = 0,
    xs = 0,
    ys = 0,
    o = 0,
    r = 0 
}
Entity.name = "Entity"


-- players fly around in spacesuits and shoot at each other
Player = Entity:extends
{
    thrusterFront = Thruster:new(40, 1),
    thrusterLeft = Thruster:new(40, 1),
    thrusterRight = Thruster:new(40, 1),
    thrusterBack = Thruster:new(40, 1),
    thrusterRotateLeft = Thruster:new(2, 0.1),
    thrusterRotateRight = Thruster:new(2, 0.1),
}
Player.name = "Player"