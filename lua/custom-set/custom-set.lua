local Set = {}

function Set:create(contents)
    local _set = {}
    for _, v in ipairs(contents) do
        _set[v] = true
    end

    local new_set = {_set=_set}
    setmetatable(new_set, self)
    self.__index = self
    return new_set
end

function Set:add(entry)
    self._set[entry] = true
end

function Set:is_empty()
    for _, v in pairs(self._set) do
        return false
    end
    return true
end

function Set:contains(entry)
    return self._set[entry] ~= nil
end

function Set:is_subset(other)
    for k, _ in pairs(self._set) do
        if not other:contains(k) then
            return false
        end
    end
    return true
end

function Set:is_disjoint(other)
    for k, _ in pairs(self._set) do
        if other:contains(k) then
            return false
        end
    end
    return true
end

function Set:equals(other)
    for k, _ in pairs(self._set) do
        if not other:contains(k) then
            return false
        end
    end

    for k, _ in pairs(other._set) do
        if not self:contains(k) then
            return false
        end
    end

    return true
end

function Set:intersection(other)
    local set = Set:create({})

    for k, _ in pairs(self._set) do
        if other:contains(k) then 
            set:add(k)
        end
    end

    for k, _ in pairs(other._set) do
        if self:contains(k) then
            set:add(k)
        end
    end

    return set
end

function Set:difference(other)
    local set = Set:create({})
    
    for k, _ in pairs(self._set) do
        if not other:contains(k) then 
            set:add(k)
        end
    end

    return set
end

function Set:union(other)
    local set = Set:create({})

    for k, _ in pairs(self._set) do
        set:add(k)
    end

    for k, _ in pairs(other._set) do
        set:add(k)
    end

    return set
end

return function(...)
    return Set:create({...})
end
