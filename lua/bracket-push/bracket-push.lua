local BracketPair = {}

function between(n, s, e)
    return s < n and n < e
end

function BracketPair:new(start_index, end_index)
    new_bracket_pair = {start_index=start_index, end_index=end_index}
    setmetatable(new_bracket_pair, self)
    self.__index = self
    return new_bracket_pair
end

function BracketPair:intersects_with(other)
    return (
        between(other.start_index, self.start_index, self.end_index) and not
        between(other.end_index, self.start_index, self.end_index)
    ) or (
        between(other.end_index, self.start_index, self.end_index) and not
        between(other.start_index, self.start_index, self.end_index)
    )
end

local function all_index_of(contents, bracket)
    local result = {}

    for i = 1, #contents do
        if contents:sub(i, i) == bracket then
            table.insert(result, i)
        end
    end

    return result
end

local function match(contents, start_bracket, end_bracket) 
    local result = {}

    local start_indicies = all_index_of(contents, start_bracket)
    local end_indicies = all_index_of(contents, end_bracket)

    if #start_indicies ~= #end_indicies then
        return false
    end

    for i = #start_indicies, 1, -1 do
        local match_index = -1

        for j = 1, i do
            if end_indicies[j] > start_indicies[i] then
                match_index = end_indicies[j]
                table.remove(end_indicies, j)
                break
            end
        end

        if match_index == -1 then
            return false
        end

        table.insert(result, BracketPair:new(
            start_indicies[i],
            match_index 
        ))
    end

    return result
end

local brackets = {}


function brackets.valid(contents)
    bracket_pairs = {}

    local matched = match(contents, "(", ")")
    if not matched then
        return false
    end

    for i = 1, #matched do
        table.insert(bracket_pairs, matched[i])
    end

    local matched = match(contents, "{", "}")
    if not matched then
        return false
    end

    for i = 1, #matched do
        table.insert(bracket_pairs, matched[i])
    end

    local matched = match(contents, "[", "]")
    if not matched then
        return false
    end

    for i = 1, #matched do
        table.insert(bracket_pairs, matched[i])
    end

    for i = 1, #bracket_pairs do
        for j = i + 1, #bracket_pairs do
            if bracket_pairs[i]:intersects_with(bracket_pairs[j]) then
                print(bracket_pairs[i].start_index)
                print(bracket_pairs[i].end_index)
                print(bracket_pairs[j].start_index)
                print(bracket_pairs[j].end_index)
                return false
            end
        end
    end

    return true
end

 return brackets
