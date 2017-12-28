local function is_isogram(phrase)
    local seen = {}
    for character in phrase:lower():gmatch("[a-z]") do
        if seen[character] then
            return false
        end
        seen[character] = true
    end

    return true
end

return is_isogram
