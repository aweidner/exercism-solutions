local function go_in_direction(x, y, heading)
    if heading == "north" then
        return x, y + 1
    elseif heading == "south" then
        return x, y - 1
    elseif heading == "east" then
        return x + 1, y
    else
        return x - 1, y
    end
end

local function move(self, sequence)
    assert(not sequence:match("[^LAR]"))

    local heading_table = {
        north={R="east", L="west"},
        south={R="west", L="east"},
        east={R="south", L="north"},
        west={R="north", L="south"}
    }

    for command in sequence:gmatch(".") do
        if command == "A" then
            self.x, self.y = go_in_direction(self.x, self.y, self.heading)
        else 
            self.heading = heading_table[self.heading][command] 
        end
    end
end

local function robot(initial)
    return {
        x = initial.x,
        y = initial.y,
        heading = initial.heading,
        move = move
    }
end

return robot
