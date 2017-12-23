local function find_recursive(array, to_locate, first, last)
    if first > last then
        return -1
    end

    midpoint = math.floor((first + last) / 2)

    if to_locate > array[midpoint] then
        return find_recursive(array, to_locate, midpoint + 1, last)
    elseif to_locate < array[midpoint] then
        return find_recursive(array, to_locate, first, midpoint - 1)
    else
        return midpoint
    end
end

local function find(array, to_locate)
    return find_recursive(array, to_locate, 1, #array)
end


return find
