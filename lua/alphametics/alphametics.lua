local function any_the_same(table)
    local check = {}
    for _, v in pairs(table) do
        if check[v] then
            return true
        end
        check[v] = true
    end
    return false
end

local function combinations(characters, cant_be_zero)
    return coroutine.wrap(function()
        local combos = {}
        for c in characters:gmatch(".") do
            combos[c] = 0
            if cant_be_zero:find(c) then
                combos[c] = 1
            end
        end

        repeat
            if not any_the_same(combos) then
                coroutine.yield(combos)
            end
            local incremented_one = false
            for character, digit in pairs(combos) do 
                if digit + 1 < 10 then
                    combos[character] = digit + 1
                    incremented_one = true
                    break
                else
                    combos[character] = 0 
                    if cant_be_zero:find(character) then
                        combos[character] = 1
                    end
                end
            end
        until not incremented_one
    end)
end

return {
    solve = function(puzzle)
        local unique_characters = ""
        local cant_be_zero = puzzle:sub(1, 1)

        for c in puzzle:gmatch("[A-Z]") do
            if not unique_characters:find(c) then
                unique_characters = unique_characters .. c
            end
        end

        for c in puzzle:gmatch(" ([A-Z])") do
            cant_be_zero = cant_be_zero .. c
        end

        for combo in combinations(unique_characters, cant_be_zero) do
            local test_string = puzzle:sub(1, #puzzle)
            for character, digit in pairs(combo) do
                test_string = test_string:gsub(character, digit)
            end

            if load("return " .. test_string)() then
                return combo
            end
        end
    end
}
