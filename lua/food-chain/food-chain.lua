local song = {}

local catch = {
    {"fly", ""},
    {"spider", "fly"},
    {"bird", "spider that wriggled and jiggled and tickled inside her"},
    {"cat", "bird"},
    {"dog", "cat"},
    {"goat", "dog"},
    {"cow", "goat"},
    {"horse", ""}
}

function death(n)
    if n == 8 then
        return "She's dead, of course!\n"
    else
        return "I don't know why she swallowed the fly. Perhaps she'll die.\n"
    end
end

function to_catch(n)
    lead_in = "She swallowed the " .. catch[n][1] .. " to catch the " .. catch[n][2] .. ".\n"
    if n < 2 or n > 7 then
        return ""
    elseif n == 2 then
        return lead_in
    else
        return lead_in .. to_catch(n - 1)
    end
end

function song.verse(n)
    local lead = "I know an old lady who swallowed a "
    
    local exclaim = {
        "",
        "It wriggled and jiggled and tickled inside her.\n",
        "How absurd to swallow a bird!\n",
        "Imagine that, to swallow a cat!\n",
        "What a hog, to swallow a dog!\n",
        "Just opened her throat and swallowed a goat!\n",
        "I don't know how she swallowed a cow!\n",
        ""
    }

    return lead .. catch[n][1] .. ".\n" .. exclaim[n] .. to_catch(n) .. death(n)
end

function song.verses(start, stop)
    local result = {}

    for i = start, stop do
        table.insert(result, song.verse(i))
    end

    return table.concat(result, '\n') .. '\n'
end

function song.sing()
    return song.verses(1, 8)
end

return song
