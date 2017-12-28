local DNA = {}

function DNA:new(str)
    local new_dna = {dna=str}
    setmetatable(new_dna, self)
    self.__index = self

    new_dna.nucleotideCounts = {} 

    for character in string.gmatch("CTGA", ".") do
        new_dna.nucleotideCounts[character] = new_dna:count(character)
    end

    return new_dna
end

function DNA:count(character)
    if not string.match("CTGA", character) then error('Invalid Nucleotide') end

    local result = 0
    for _ in self.dna:gmatch(character) do
        result = result + 1
    end
    return result
end

return DNA
