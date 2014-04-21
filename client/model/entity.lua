
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