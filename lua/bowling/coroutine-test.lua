local function test_clean()
    local test = coroutine.yield()
    print(test)
    test = coroutine.yield()
    print(test)
    test = coroutine.yield()
    print(test)
end

cr = coroutine.create(test_clean)
print(coroutine.resume(cr, 3))
print(coroutine.resume(cr, 4))
print(coroutine.resume(cr, 5))
