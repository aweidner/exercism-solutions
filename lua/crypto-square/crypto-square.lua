local crypto = {}

function crypto.normalized_plaintext(text)
    return text:lower():gsub("[^a-z0-9]", "")
end

function crypto.size(text)
    return math.ceil(math.sqrt(#crypto.normalized_plaintext(text)))
end

function crypto.segments(text)
    local size = crypto.size(text)
    local normalized = crypto.normalized_plaintext(text)
    local result = {}

    for group in normalized:gmatch(string.rep(".", size)) do
        table.insert(result, group)
    end

    if #normalized % size ~= 0 then
        table.insert(result,
            normalized:sub(
                #normalized - (#normalized % size) + 1,
                #normalized
            )
        )
    end
     
    return result
end

function crypto.normalized_ciphertext(text)
    local segments = crypto.segments(text)
    local result = {} 

    for column = 1, #segments[1] do
        local chunk = ""
        for row = 1, #segments do
            chunk = chunk .. segments[row]:sub(column, column)
        end
        table.insert(result, chunk)
    end

    return table.concat(result, " ")
end

function crypto.ciphertext(text)
    return crypto.normalized_ciphertext(text):gsub(" ", "")
end

return crypto
