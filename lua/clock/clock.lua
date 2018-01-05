local Clock = {}

function Clock:new(minute)
    local new_clock = {minute=minute}
    setmetatable(new_clock, Clock)
    self.__index = self
    return new_clock
end

function Clock:plus(minute)
    return Clock:new(self.minute + minute)
end

function Clock:minus(minute)
    return self:plus(-1 * minute) 
end

function Clock:equals(other)
    return tostring(self) == tostring(other) 
end

function Clock:__tostring()
    return string.format("%02d:%02d", (self.minute // 60) % 24, self.minute % 60)
end

local module = {}

function module.at(hour, minute) 
    return Clock:new(hour * 60 + (minute or 0))
end

return module
