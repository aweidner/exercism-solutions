return function(words)
    local result = ""
    for word in words:gmatch("%a+") do
        result = result .. word:sub(1, 1):upper()
        for internal_caps in word:sub(2, #word):gmatch("([A-Z])[^A-Z]") do
            result = result .. internal_caps 
        end
    end
    return result
end
