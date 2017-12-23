local diff = {}

function diff.square_of_sums(n)
    local total = 0
    for i = n, 1, -1 do
        total = total + i
    end
    return total ^ 2
end

function diff.sum_of_squares(n)
    if n == 0 then
        return 0
    end
    return math.pow(n, 2) + diff.sum_of_squares(n - 1)
end

function diff.difference_of_squares(n)
    return diff.square_of_sums(n) - diff.sum_of_squares(n)
end

return diff
