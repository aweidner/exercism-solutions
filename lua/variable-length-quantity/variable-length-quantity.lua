local vlq = {}

function vlq.decode(arr)
    if (arr[#arr] >> 7) > 0 then
        error("incomplete byte sequence")
    end

    local result = {}
    local intermediate = 0

    for i = 1, #arr do
        intermediate = (intermediate << 7) | (arr[i] & 0x7F)

        if arr[i] >> 7 == 0 then
            table.insert(result, intermediate)
            intermediate = 0
        end
    end

    return result
end

local function encode_single(n)
    if n == 0 then
        return { 0x00 }
    end

    local encoded = {}

    while n > 0 do
        table.insert(encoded, 1, (n & 0x7F) | 0x80)
        n = n >> 7  
    end

    encoded[#encoded] = encoded[#encoded] & 0x7F
    return encoded
end

function vlq.encode(arr)
    local result = {}

    for i = 1, #arr do
        local encoded = encode_single(arr[i])
        for j = 1, #encoded do
            table.insert(result, encoded[j])
        end
    end

    return result
end

return vlq
