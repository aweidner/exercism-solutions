local function sound(n, div, sound)
    if n % div == 0 then return sound else return "" end
end

local function raindrops(n)
    result = sound(n, 3, "Pling") .. sound(n, 5, "Plang") .. sound(n, 7, "Plong") 
    if result == "" then return tostring(n) else return result end
end


return raindrops
