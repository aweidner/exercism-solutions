local function Octal(octal_string)
    octal_object = {}

    function octal_object:to_decimal()
        local result = 0
        local conversion = {
            ["0"]=0, ["1"]=1, ["2"]=2, ["3"]=3, ["4"]=4,
            ["5"]=5, ["6"]=6, ["7"]=7
        }

        for i = 1, #octal_string do
            local numerical = conversion[octal_string:sub(i, i)]

            if not numerical then
                return 0
            end

            result = (result +
                      numerical *
                      8 ^ (#octal_string - i))
        end

        return result
    end

    return octal_object
end


return Octal
