local function flatten(array)
    local not_fully_flattened = false

    for i = 1, #array do
        if type(array[i]) == "table" then 
            local length_of_inner_array = #array[i]
            for j = 1, length_of_inner_array do
                if type(array[i][j]) == "table" then
                    not_fully_flattened = true
                end
                table.insert(array, i + j, array[i][j])
            end
            table.remove(array, i)
        end
    end

    if not_fully_flattened then
        return flatten(array)
    else
        return array
    end
end

return flatten
