local function verify(tape)
    local last_start = 0

    while tape:find("\n", last_start + 1) do
        start, _ = tape:find("\n", last_start + 1)
        assert(start % 4 == 0)
        last_start = start
    end
end

local function move_to_next_number(tape_index)
    return tape_index + 3
end

local function number_width(tape_index)
    return tape_index + 2
end

local function index_of_character_at(row, col, newline_distance)
    return (newline_distance + 1) * row + col
end

local function iterate_columns_in_row(tape, tape_index, newline_distance, row_index)
    return coroutine.wrap(function()
        for col = tape_index, number_width(tape_index) do
            local index = index_of_character_at(row_index, col, newline_distance)
            coroutine.yield(tape:sub(index, index))
        end
    end)
end

local function iterate_string_row(tape, tape_index, newline_distance)
    return coroutine.wrap(function()
        for row_index = 0, 2 do
            local row = ""
            for col_value in iterate_columns_in_row(tape, tape_index, newline_distance, row_index) do
                row = row .. col_value
            end
            coroutine.yield(row)
        end
    end)
end

local function iterate_row(tape, start)
    return coroutine.wrap(function()
        local newline_distance = tape:find("\n", start) - start
        local tape_index = start 

        while tape_index < start + newline_distance do
            local result = ""     
            for row in iterate_string_row(tape, tape_index, newline_distance) do
                result = result .. row .. "\n"
            end
            coroutine.yield(result)
            tape_index = move_to_next_number(tape_index)
        end
    end)
end

local function iterate(tape)
    return coroutine.wrap(function()
        local row_length, _ = tape:find("\n")
        for row = 0, #tape / row_length / 4 do
            if row > 0 then
                coroutine.yield(",")
            end
            for chunk in iterate_row(tape, 1 + row * 4 * row_length) do
                coroutine.yield(chunk)
            end
        end
    end)
end

local ocr = {}

function ocr.convert(tape)
    local patterns = {
        [","] = ",",
        ["0"] = (" _ \n" ..
                 "| |\n" ..
                 "|_|\n"),
        ["1"] = ("   \n" ..
                 "  |\n" ..
                 "  |\n"),
        ["2"] = (" _ \n" ..
                 " _|\n" ..
                 "|_ \n"),
        ["3"] = (" _ \n" ..
                 " _|\n" ..
                 " _|\n"),
        ["4"] = ("   \n" ..
                 "|_|\n" ..
                 "  |\n"),
        ["5"] = (" _ \n" ..
                 "|_ \n" ..
                 " _|\n"),
        ["6"] = (" _ \n" ..
                 "|_ \n" ..
                 "|_|\n"),
        ["7"] = (" _ \n" ..
                 "  |\n" ..
                 "  |\n"),
        ["8"] = (" _ \n" ..
                 "|_|\n" ..
                 "|_|\n"),
        ["9"] = (" _ \n" ..
                 "|_|\n" ..
                 " _|\n"),
    }

    result = ""
    for chunk in iterate(tape) do
        local found_pattern = false
        for value, pattern in pairs(patterns) do
            if chunk == pattern then
                result = result .. value
                found_pattern = true
            end
        end

        if not found_pattern then
            verify(chunk)
            result = result .. "?"
        end
    end

    return result
end

return ocr
