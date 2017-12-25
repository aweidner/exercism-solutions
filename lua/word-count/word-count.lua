local wc = {}

function wc.word_count(words)
    local buckets = {}

    for word in string.gmatch(words, "[a-zA-Z0-9]+") do
        buckets[word:lower()] = (buckets[word:lower()] or 0) + 1
    end

    return buckets
end

return wc
