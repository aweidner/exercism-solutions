local bob = {}

local function is_upper_case(segment)
    return segment:upper() == character
end

local function shouting(possible_shouting)
    -- Shouting is defined as anything that
    -- is predominately upper case characters
    -- and ends in an exclamation mark
    upper_case = 0
    for i = 1, #possible_shouting  do
        if is_upper_case(possible_shouting:sub(i, i)) then
            upper_case = upper_case + 1
        end
    end

    return upper_case > #possible_shouting / 2 and possible_shouting:sub(-1) == "!"
end

local function question(possible_question)
    return possible_question:sub(-1) == "?"
end

function bob.hey(heard)
    if heard == "" then
        return "Fine, be that way."
    elseif shouting(heard) then
        return "Whoa, chill out!"
    elseif question(heard) then
        return "Sure"
    else
        return "Whatever"
    end
end

return bob
