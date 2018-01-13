local rail = {}

local function rail_indicies(rails, stop_at)
    return coroutine.wrap(function() 
        rail_increment = 1
        rail_index = 1

        for i = 1, stop_at do
            coroutine.yield(rail_index)
            rail_index = rail_index + rail_increment
            if rail_index == 1 or rail_index == rails then
                rail_increment = rail_increment * -1
            end
        end
    end)
end

function rail.encode(decoded, rail_count)
    local rails = {}
    local ci = 1

    for rail_index in rail_indicies(rail_count, #decoded) do
        rails[rail_index] = (rails[rail_index] or "") .. decoded:sub(ci, ci)
        ci = ci + 1
    end

    return table.concat(rails, "")
end

function rail.decode(encoded, rail_count)
    local rails = {}
    for rail_index in rail_indicies(rail_count, #encoded) do
        rails[rail_index] = (rails[rail_index] or "") .. "X"
    end
    
    local taken = 0
    for i, _ in ipairs(rails) do
        rails[i] = encoded:sub(taken + 1, taken + #rails[i])
        taken = taken + #rails[i]
    end

    local result = ""
    for rail_index in rail_indicies(rail_count, #encoded) do
        result = result .. rails[rail_index]:sub(1, 1)
        rails[rail_index] = rails[rail_index]:sub(2, #rails[rail_index])
    end

    return result
end

return rail
