local etl = {}

function etl.transform(tiles)
    local result = {}
    
    for score, letter_list in pairs(tiles) do
        for _, letter in pairs(letter_list) do
            result[letter:lower()] = score
        end
    end

    return result
end

return etl
