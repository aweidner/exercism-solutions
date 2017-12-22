local house = {}


verses = {
    {modifier="lay in", subject="house that Jack built."},
    {modifier="ate", subject="malt"},
    {modifier="killed", subject="rat"},
    {modifier="worried", subject="cat"},
    {modifier="tossed", subject="dog"},
    {modifier="milked", subject="cow with the crumpled horn"},
    {modifier="kissed", subject="maiden all forlorn"},
    {modifier="married", subject="man all tattered and torn"},
    {modifier="woke", subject="priest all shaven and shorn"},
    {modifier="kept", subject="rooster that crowed in the morn"},
    {modifier="belonged to", subject="farmer sowing his corn"},
    {modifier="", subject="horse and the hound and the horn"}
}

function house.verse(index)
    local result = {} 

    for i = index, 1, -1 do
        table.insert(result, build_verse(i, i == index))
    end

    return table.concat(result, "\n")
end

function house.recite()
    local result = {}
    
    for i = 1, #verses do
        table.insert(result, house.verse(i))
    end

    return table.concat(result, "\n")
end

function build_verse(index, is_first_verse)
    if is_first_verse then
        return "This is the " .. verses[index]["subject"]
    else
        return ("that " .. verses[index]["modifier"] ..
                " the " .. verses[index]["subject"])
    end
end

return house
