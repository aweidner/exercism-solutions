return function(sentence)
    local vowel_sounds = {"^yt", "^xr", "^[aeiou]"}
    local consanant_sounds = {"^.*qu", "^thr", "^th", "^sch", "^ch", "^[^aeiou]"}

    return sentence:gsub("%a+", function(word)
        for _, vowel_sound in pairs(vowel_sounds) do
            if word:lower():find(vowel_sound) then
                return word .. "ay"
            end
        end

        for _, consanant_sound in pairs(consanant_sounds) do
            si, ei = word:lower():find(consanant_sound)
            if si then
                return word:sub(ei + 1, #word) .. word:sub(si, ei) .. "ay"
            end
        end
    end)
end
