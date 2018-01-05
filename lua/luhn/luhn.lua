return {
    valid=function(number)
        number = number:gsub(" ", "")
        if #number < 2 or number:match("%D") then
            return false
        end

        local sum = 0

        for i = 1, #number do
            digit = tonumber(number:sub(i, i))

            if i % 2 ~= #number % 2 then
                digit = 2 * digit
                if digit > 9 then
                    digit = digit - 9
                end
            end

            sum = sum + digit
        end

        return sum % 10 == 0
    end
}
