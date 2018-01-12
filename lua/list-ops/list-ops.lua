local function to_table(iterator)
    local result = {}
    for item in iterator do
        table.insert(result, item)
    end
    return result
end

local function map(table, f)
    return coroutine.wrap(function()
        for _, v in pairs(table) do
            coroutine.yield(f(v))
        end
    end)
end

local function filter(table, f)
    return coroutine.wrap(function()
        for _, v in pairs(table) do
            if f(v) then
                coroutine.yield(v)
            end
        end
    end)
end

return {
    map = function(table, f) return to_table(map(table, f)) end,
    reduce = function(table, start, accumulator)
        local result = start
        for _, v in pairs(table) do
            result = accumulator(v, result)
        end
        return result
    end,
    filter = function(table, f) return to_table(filter(table, f)) end
}
