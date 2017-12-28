local pn = {}

local function divisions(n)
    local result = {}
    for i = 1, math.floor(n / 2) do
        if n % i == 0 then
            table.insert(result, i)
        end
    end
    return result
end

function pn.aliquot_sum(n)
    local result = 0
    for _, v in ipairs(divisions(n)) do
        result = result + v
    end
    return result
end

function pn.classify(n)
    local sum = pn.aliquot_sum(n)
    if sum == n then
        return "perfect"
    elseif sum < n then
        return "deficient"
    else
        return "abundant"
    end
end

return pn
