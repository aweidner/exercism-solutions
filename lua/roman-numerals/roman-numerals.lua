local numerals = {
    {1000, "M"},
    {900, "CM"},
    {500, "D"},
    {400, "CD"},
    {100, "C"},
    {90, "XC"},
    {50, "L"},
    {40, "XL"},
    {10, "X"},
    {9, "IX"},
    {5, "V"},
    {4, "IV"},
    {1, "I"}
}

local function to_roman(number)
    for _, number_to_numeral in pairs(numerals) do
        local reference_number = number_to_numeral[1]
        if number >= reference_number then
            return number_to_numeral[2] .. to_roman(number - reference_number)
        end
    end

    return ""
end

return { to_roman = to_roman }
