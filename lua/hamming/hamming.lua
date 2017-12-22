local hamming = {}

function hamming.compute(strand_one, strand_two)
    total_distance = 0

    if string.len(strand_one) ~= string.len(strand_two) then
        return -1
    end

    for i = 1, string.len(strand_one) do 
        if string.sub(strand_one, i, i) ~= string.sub(strand_two, i, i) then
            total_distance = total_distance + 1
        end
    end

    return total_distance
end

return hamming
