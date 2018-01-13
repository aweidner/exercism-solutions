local function product(chunk)
    local product = 1
    for i = 1, #chunk do
        product = product * tonumber(chunk:sub(i, i))
    end
    return product
end

local function chunks_of_digits(digits, span)
    return coroutine.wrap(function()
        for i = 1, #digits - span + 1 do
            coroutine.yield(digits:sub(i, i + span - 1))
        end
    end)
end

return function(args)
    assert(args.span >= 0)
    assert(not args.digits:match("[^0-9]"))
    assert(#args.digits)
    assert(args.span <= #args.digits)

    local max_so_far = 0

    for chunk in chunks_of_digits(args.digits, args.span) do
        local latest_product = product(chunk)
        if latest_product > max_so_far then
            max_so_far = latest_product
        end
    end

    return max_so_far
end
