return function(to_reverse)
    local result = ""
    for i = #to_reverse, 1, -1 do
        result = result .. to_reverse:sub(i, i)
    end
    return result
end
