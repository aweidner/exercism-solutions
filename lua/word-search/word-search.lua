
local function get(grid, node)
    good, result = pcall(function() return grid[node[2]]:sub(node[1], node[1]) end)
    if good then return result else return nil end
end

local function start_indexes(puzzle, find_letter)
    return coroutine.wrap(function()
        for line_index, line in ipairs(puzzle) do
            for word_index = 1, #line do
                if line:sub(word_index, word_index) == find_letter then
                    coroutine.yield({word_index, line_index})
                end
            end
        end
    end)
end

local function search(grid, start, find, vector)
    if get(grid, start) == find then
        return start
    end

    local node = {start[1] + vector[1], start[2] + vector[2]}
    if get(grid, node) == find:sub(2, 2) then
        local stop = search(grid, node, find:sub(2, #find), vector)
        if stop then
            return stop
        end
    end
end

return function(puzzle)
    local vectors = { {1, 0}, {-1, 0}, {0, 1}, {0, -1}, {1, 1}, {-1, -1}, {1, -1}, {-1, 1} }
    return {
        find = function(word)
            for start in start_indexes(puzzle, word:sub(1, 1)) do
                for _, vector in ipairs(vectors) do
                    local stop = search(puzzle, start, word, vector)
                    if stop then
                        return start, stop
                    end
                end
            end
        end
    }
end
