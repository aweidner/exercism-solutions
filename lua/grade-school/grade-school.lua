local School = {}

function School:new()
    local new_school = {_roster={}}
    setmetatable(new_school, self)
    self.__index = self
    return new_school
end

function School:add(name, grade)
    self._roster[grade] = self._roster[grade] or {}
    table.insert(self._roster[grade], name)
    -- Super inefficient if performance is needed should use a
    -- list kept in permanently sorted order
    table.sort(self._roster[grade])
end

function School:roster()
    return self._roster
end

function School:grade(grade)
    return self._roster[grade] or {}
end

return School
