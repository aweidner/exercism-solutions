local Robot = {}

local function random_letter()
    letters = "ABCDEFGHIJKLMNOPQRSTUV"
    n = math.random(26)
    return letters:sub(n, n)
end

local function generate_name()
    return (
        random_letter() ..
        random_letter() ..
        math.random(0, 9) ..
        math.random(0, 9) ..
        math.random(0, 9))
end

function Robot:new()
    local new_robot = {name=generate_name()}
    setmetatable(new_robot, self)
    self.__index = self
    return new_robot
end

function Robot:reset()
    self.name = generate_name()
end

return Robot
