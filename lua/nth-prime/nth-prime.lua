local function nth(n)
    assert(n > 0)

    local primes_so_far = {}
    next_prime_candidate = 2

    while #primes_so_far < n do
        local prime = true
        for _, v in ipairs(primes_so_far) do
            if next_prime_candidate % v == 0 then
                prime = false
                break
            end

            if math.pow(v, 2) > next_prime_candidate then
                break
            end
        end
        
        if prime then
            table.insert(primes_so_far, next_prime_candidate)
        end

        next_prime_candidate = next_prime_candidate + 1
    end

    return primes_so_far[#primes_so_far]
end

return nth
