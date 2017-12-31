local SpaceAge = {}

local function round(number, places)
    return math.floor(number * 10^places + 0.5) / 10^places
end

function SpaceAge:new(seconds)
    local on_earth = seconds / 31557600
    return {
        seconds=seconds,
        on_earth = function() return round(on_earth, 2) end,
        on_mercury = function() return round(on_earth / .2408467, 2) end,
        on_venus = function() return round(on_earth / .61519726, 2) end,
        on_mars = function() return round(on_earth / 1.8808158, 2) end,
        on_jupiter = function() return round(on_earth / 11.862615, 2) end,
        on_saturn = function() return round(on_earth / 29.447498, 2) end,
        on_uranus = function() return round(on_earth / 84.016846, 2) end,
        on_neptune = function() return round(on_earth / 164.79132, 2) end
    }
end

return SpaceAge
