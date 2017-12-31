local function pascals(max_rows)
    local result = { { 1 } }
    for i = 2, max_rows do 
        local row = { 1 }
        for j = 2, #result[i - 1] do
            table.insert(row, result[i - 1][j - 1] + result[i - 1][j])
        end
        table.insert(row, 1)
        table.insert(result, row)
    end
    return result
end

function Triangle(max_rows)
    rows = pascals(max_rows)
    return {
        rows=rows,
        last_row=rows[#rows]
    }
end

return Triangle
