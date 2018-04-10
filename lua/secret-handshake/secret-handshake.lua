return function(secret)
    local decode = {
        "wink", "double blink", "close your eyes", "jump"
    }

    local is_reversed = secret & 16 > 0
    local result = {}

    for n, code in pairs(decode) do
        if secret & 2^(n - 1) > 0 then
            table.insert(result, is_reversed and 1 or #result + 1, code)
        end
    end

    return result
end
