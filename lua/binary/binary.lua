return {
    to_decimal = function(binary)
        if binary:match("[^01]") then return 0 end
        local sum = 0

        for i = #binary, 1, -1 do
            sum = sum + tonumber(binary:sub(i, i)) * 2 ^ (#binary - i)
        end

        return sum
    end
}
