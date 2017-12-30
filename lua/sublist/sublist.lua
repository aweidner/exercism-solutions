return function(sublist, list)
    if #sublist > #list then return false end
    if #sublist == 0 and #list == 0 then return true end

    for index, _ in ipairs(list) do
        local sublist_at_this_position = true
        for sublist_index, v in ipairs(sublist) do
            if list[index + sublist_index - 1] ~= v then
                sublist_at_this_position = false
                break
            end
        end
        if sublist_at_this_position then
            return true
        end
    end

    return false
end
