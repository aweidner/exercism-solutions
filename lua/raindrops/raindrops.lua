local function pling(n)
    if n % 3 == 0 then return "Pling" else return "" end
end

local function plang(n)
    if n % 5 == 0 then return "Plang" else return "" end
end

local function plong(n)
    if n % 7 == 0 then return "Plong" else return "" end
end

local function raindrops(n)
    result = pling(n) .. plang(n) .. plong(n)
    if result == "" then return tostring(n) else return result end
end


return raindrops
