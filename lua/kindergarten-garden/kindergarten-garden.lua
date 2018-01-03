local function by_name(layout)
    local newline = layout:find("\n")
    return coroutine.wrap(function()
        for i = 1, newline, 2 do
            for _, v in ipairs({0, newline}) do
                coroutine.yield(layout:sub(v + i, v + i))
                coroutine.yield(layout:sub(v + i + 1,  v + i + 1))
            end
        end
    end)
end

local function group(layout, n)
    local plant_types = {R="radishes", C="clover", G="grass", V="violets"}

    return coroutine.create(function()
        local group = {}
        for item in layout do
            table.insert(group, plant_types[item:upper()])
            if #group == n then
                coroutine.yield(group)
                group = {}
            end
        end
    end)
end

return function(layout)
    local garden = group(by_name(layout), 4)

    local garden_by_child = {}
    for _, name in ipairs({"alice", "bob", "charlie", "david",
                           "eve", "fred", "ginny", "harriet",
                           "ileana", "joseph", "kincaid", "larry"}) do
        _, garden_by_child[name] = coroutine.resume(garden)
    end

    return setmetatable({}, {
        __index = function(self, index) return garden_by_child[index:lower()] or {} end
    })
end
