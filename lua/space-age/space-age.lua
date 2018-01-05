local SpaceAge = {}

local function round(number, places)
    return math.floor(number * 10^places + 0.5) / 10^places
end

function SpaceAge:new(seconds)
    local planets = {
        on_earth = 1,
        on_mercury = .2408467,
        on_venus = .61519726,
        on_mars = 1.8808158,
        on_jupiter = 11.862615,
        on_saturn = 29.447498,
        on_uranus = 84.016846,
        on_neptune = 164.79132
    }

    return setmetatable({
        seconds=seconds,
    }, {
        __index = function(self, where)
            return function() 
                return round(seconds / 31557600 / planets[where], 2)
            end
        end
    })
end

return SpaceAge
