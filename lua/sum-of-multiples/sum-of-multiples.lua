local function sum_of_multiples(multiples_array)
    local function to(n)
        local sum = 0

        for i = 2, n - 1 do
            for _, m in ipairs(multiples_array) do
                if i % m == 0 then
                    sum = sum + i
                    break
                end
            end
        end

        return sum
    end

    return {to=to}
end

return sum_of_multiples
