local function to_array(str)
    local result = {}

    for i = 1, str:len() do
        table.insert(result, str:sub(i, i):lower())
    end

    return result
end

local function is_anagram_of(word, possible_anagram)
    if word:len() ~= possible_anagram:len() then
        return false
    end

    local chars_in_word = to_array(word)
    local chars_in_anagram = to_array(possible_anagram)

    table.sort(chars_in_word)
    table.sort(chars_in_anagram)

    for i = 1, #chars_in_word do
        if chars_in_word[i] ~= chars_in_anagram[i] then
            return false
        end
    end

    return true
end

local Anagram = {}

function Anagram:new(source)
    local new_anagram = {source=source}
    setmetatable(new_anagram, self)
    self.__index = self
    return new_anagram
end

function Anagram:match(possible_matches)
    local result = {}

    for i = 1, #possible_matches do
        if is_anagram_of(self.source, possible_matches[i]) then
            table.insert(result, possible_matches[i])
        end
    end

    return result
end

return Anagram
