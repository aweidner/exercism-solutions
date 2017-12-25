local function is_pangram(letters)
    local all_letters = "abcdefghijklmnopqrstuvwxyz"
    local letters_score = {}

    for i = 1, #all_letters do
        letters_score[all_letters:sub(i, i)] = 0
    end

    for i = 1, #letters do
        letter = letters:sub(i, i):lower()
        letters_score[letter] = (letters_score[letter] or 0) + 1
    end

    for _, v in pairs(letters_score) do
        if v == 0 then
            return false
        end
    end

    return true
end

return is_pangram 
