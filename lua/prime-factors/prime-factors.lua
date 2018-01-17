return function(n)
    local factors = {}
    local possible_factor = 2
    while n > 1 do
        if n % possible_factor == 0 then
            table.insert(factors, possible_factor)
            n = n / possible_factor
        else
            possible_factor = possible_factor + 1
        end
    end
    return factors
end
