local Team = {}

function Team:new(name)
    local new_team = {name = name, w = 0, d = 0, l = 0}
    setmetatable(new_team, self)
    self.__index = self
    return new_team
end

function Team:win()
    self.w = self.w + 1
end

function Team:loss()
    self.l = self.l + 1
end

function Team:draw()
    self.d = self.d + 1
end

function Team:points()
    return self.w * 3 + self.d
end

function Team:played()
    return self.w + self.d + self.l
end

function Team:marshal()
    return ("%-31s| %2d | %2d | %2d | %2d | %2d"):format(
        self.name, self:played(), self.w, self.d, self.l, self:points())
end

local Standings = {}

function Standings:new()
    local new_standings = {teams = {}}
    setmetatable(new_standings, self)
    self.__index = self
    return new_standings
end

function Standings:team(name)
    -- Either find the existing team that matches this name
    -- or return a new team with the given name.
    --
    -- The list is searched in this function so that we can allow
    -- sorting in the marshal function
    for _, t in pairs(self.teams) do
        if t.name == name then
            return t
        end
    end

    table.insert(self.teams, Team:new(name))
    return self.teams[#self.teams]
end

function Standings:marshal()
    local marshaled = {'Team                           | MP |  W |  D |  L |  P'}
    table.sort(self.teams, function(a, b)
        -- Sort first by points descending and if
        -- there is a tie sort by names ascending
        if a:points() ~= b:points() then
            return a:points() > b:points() 
        else
            return a.name < b.name
        end
    end)

    for _, team in pairs(self.teams) do
        table.insert(marshaled, team:marshal())
    end

    return marshaled
end

local function parse_result(entry)
    local result = {valid = true}

    team_index = entry:find(";")

    -- If no separator was found then the results are invalid
    if not team_index then
        return {valid = false}
    end

    result_index = entry:find(";", team_index + 1)

    -- If there was no second separator or there were more separators after
    -- the second separator then the results are invalid
    if not result_index or entry:find(";", result_index + 1) then
        return {valid = false}
    end

    result.first = entry:sub(1, team_index - 1)
    result.second = entry:sub(team_index + 1, result_index - 1)
    result.result = entry:sub(result_index + 1, #entry) 

    -- Results must be one of draw, win, or loss, otherwise the
    -- results are invalid
    if result.result == "draw" then
        result.draw = true
    elseif result.result == "win" then
        result.winner = result.first
        result.loser = result.second
    elseif result.result == "loss" then
        result.winner = result.second
        result.loser = result.first
    else
        return {valid = false}
    end

    return result
end

return function(results)
    local standings = Standings:new()

    for _, entry in pairs(results) do
        local result = parse_result(entry)

        if result.valid then
            if result.draw then
                standings:team(result.first):draw()
                standings:team(result.second):draw()
            else
                standings:team(result.winner):win()
                standings:team(result.loser):loss()
            end
        end
    end
   
    return standings:marshal()
end
