
local function parse_number(number)
    number, _ = number:gsub("[^0-9]", "")

    if #number == 10 then
        return number
    elseif #number == 11 and number:sub(1, 1) == "1" then
        return number:sub(2, #number)
    else
        return '0000000000'
    end
end

local PhoneNumber = {}

function PhoneNumber:new(number)
    new_phone_number = {number=parse_number(number)}
    setmetatable(new_phone_number, self)
    self.__index = self
    return new_phone_number
end

function PhoneNumber:areaCode()
    return self.number:sub(1, 3)
end

function PhoneNumber:__tostring()
    return (
        "(" .. self.number:sub(1, 3) .. ") " ..
        self.number:sub(4, 6) .. "-" ..
        self.number:sub(7, 10))
end

return PhoneNumber
