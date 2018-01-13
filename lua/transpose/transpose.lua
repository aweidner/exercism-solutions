return function(matrix)
    local result = {}
    local preprocessed = {}

    -- Place lines into a table for easier processing
    for line in matrix:gmatch("[^\n]*") do
        table.insert(preprocessed, line)
    end

    -- Pad all words to the left with spaces
    for i = #preprocessed, 2, -1 do
        if #preprocessed[i] > #preprocessed[i -1] then
            preprocessed[i - 1] = (preprocessed[i - 1] ..
                (" "):rep(#preprocessed[i] - #preprocessed[i - 1]))
        end
    end

    -- Lines -> columns
    for _, line in pairs(preprocessed) do
        local column = 1
        for c in line:gmatch(".") do
            result[column] = (result[column] or "") .. c
            column = column + 1
        end
    end

    return table.concat(result, "\n")
end
