local pn = {}

local function divisions(n)
    return coroutine.wrap(function()
        for i = 1, math.floor(n / 2) do
            if n % i == 0 then
                coroutine.yield(i)
            end
        end
    end)
end

function pn.aliquot_sum(n)
    local result = 0
    for v in divisions(n) do
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
