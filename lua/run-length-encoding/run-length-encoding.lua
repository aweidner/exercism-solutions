local rle = {}

function rle.encode(decoded)
    for character in decoded:gmatch(".") do
        decoded = decoded:gsub(character .. character .. "+", function(match)
            return tostring(#match) .. character 
        end)
    end
    return decoded
end

function rle.decode(encoded)
    return encoded:gsub("(%d+)(.)", function(length, character)
        return character:rep(length)
    end)
end

return rle
