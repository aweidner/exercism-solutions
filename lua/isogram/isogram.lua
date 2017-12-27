local function is_isogram(phrase)
    local seen = {}
    for character in phrase:lower():gmatch("[a-z]") do
        for _, v in pairs(seen) do
            if character == v then
                return false
            end
        end
        table.insert(seen, character)
    end

    return true
end

return is_isogram
