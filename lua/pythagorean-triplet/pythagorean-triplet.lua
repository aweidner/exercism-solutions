local pyth = {}

function pyth.is_triplet(a, b, c)
    return a^2 + b^2 == c^2
end

function pyth.triplets_with(constraints)
    local result = {}
    for a = constraints.min_factor or 1, constraints.max_factor do
        for b = a + 1, constraints.max_factor do
            for c = b + 1, constraints.max_factor do
                if pyth.is_triplet(a, b, c) and ((a + b + c) == (constraints.sum or (a + b + c))) then
                    table.insert(result, {a, b, c})
                end
            end
        end
    end
    return result
end
return pyth
