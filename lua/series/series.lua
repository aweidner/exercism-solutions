return function(container, length) 
    return coroutine.wrap(function()
        for i = 1, #container - length + 1 do
            coroutine.yield(container:sub(i, i + length - 1))
        end
    end)
end
