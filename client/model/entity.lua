
-- a suit has a set of thrusters powering it
Thruster = class 
{
    power = 1, -- thrust/s
    usage = 1, -- energy/s
    state = "intact",
    active = false
}
function Thruster:__init(power, usage)
    self.power = power
    self.usage = usage
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
    thrusterFront = Thruster:new(20, 1),
    thrusterLeft = Thruster:new(20, 1),
    thrusterRight = Thruster:new(20, 1),
    thrusterBack = Thruster:new(50, 3),
    thrusterRotateLeft = Thruster:new(1, 0.1),
    thrusterRotateRight = Thruster:new(1, 0.1),
}
Player.name = "Player"