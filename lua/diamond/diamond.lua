local function onto(table, line)
    for _, v in ipairs(line) do
        table[v[1]][v[2]] = v[3]
    end
end

local function reflect_over_horizontal_axis(line)
    for index, v in ipairs(line) do
        v[1] = #line * 2 - v[1] 
    end
    return line
end

local function reflect_over_vertical_axis(line)
    for index, v in ipairs(line) do
        v[2] = #line * 2 - v[2] 
    end
    return line
end

local function diamond(end_letter)
    local result = {}
    local A = string.byte("A")
    local dimension = string.byte(end_letter) - A + 1

    for i = 1, dimension * 2 - 1 do
        local row = {}
        for j = 1, dimension * 2 - 1 do 
            table.insert(row, " ")
        end
        table.insert(result, row)
    end

    local original_line = {}
    for i = 1, dimension do
        table.insert(original_line, {i, dimension - i + 1, string.char(A + i - 1)})
    end

    onto(result, original_line)
    onto(result, reflect_over_horizontal_axis(original_line))
    onto(result, reflect_over_vertical_axis(original_line))
    onto(result, reflect_over_horizontal_axis(original_line))

    final_table = {}
    for i = 1, #result do
        table.insert(final_table, table.concat(result[i], ""))
    end
    return table.concat(final_table, "\n") .. "\n"
end

return diamond
