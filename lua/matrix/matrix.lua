local function parse(raw_string)
    local grid = {}
    for row in raw_string:gmatch("[^\n]+") do
        local parsed_row = {}
        for column in row:gmatch("[^ ]+") do
            table.insert(parsed_row, tonumber(column))
        end
        table.insert(grid, parsed_row)
    end
    return grid
end

local function Matrix(raw)
    local grid = parse(raw)

    local function column(n)
        local result = {}

        for i = 1, #grid do
            table.insert(result, grid[i][n])
        end

        return result
    end

    local function row(n)
        return grid[n]
    end

    new_matrix_object = {
        column=column,
        row=row
    }
    return new_matrix_object
end

return Matrix
