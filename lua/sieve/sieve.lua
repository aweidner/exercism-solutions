return function(up_to)
    return coroutine.create(function()
        local n_table = {}
        for i = 2, up_to do
            if not n_table[i] then
                coroutine.yield(i)
                for n = i, up_to, i do n_table[n] = true end
            end
        end
    end)
end
