local beer = {}

local function sentence_case(str)
    return str:sub(1, 1):upper() .. str:sub(2, #str)
end

local function bottles_of_beer(n)
    if n == 0 then return "no more" else return tostring(n) end
end

local function plural(word, n)
    if n == 1 then return word else return word .. "s" end
end

local function take_it_down(n)
    if n > 1 then
        return "Take one down and pass it around"
    elseif n == 1 then
        return "Take it down and pass it around"
    else
        return "Go to the store and buy some more"
    end
end

local function count_of_less_one_bottle(n)
    if n > 0 then return n - 1 else return 99 end
end

function beer.verse(n)
    return (sentence_case(bottles_of_beer(n)) ..
        " " ..
        plural("bottle", n) ..
        " of beer on the wall, " ..
        bottles_of_beer(n) ..
        " " ..
        plural("bottle", n) ..
        " of beer.\n" ..
        take_it_down(n) ..
        ", " ..
        bottles_of_beer(count_of_less_one_bottle(n)) ..
        " " ..
        plural("bottle", count_of_less_one_bottle(n)) ..
        " of beer on the wall.\n")
end

function beer.sing(start, stop)
    if not stop then stop = 0 end

    result = {}

    for i = start, stop, -1 do
        table.insert(result, beer.verse(i))
    end

    return table.concat(result, "\n")
end

return beer
