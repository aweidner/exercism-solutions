local pyth = {}

local Node = {}

function Node:new(a, b, c)
    new_node = {a=a, b=b, c=c}
    setmetatable(new_node, self)
    self.__index = self
    return new_node
end

function Node:equals(other)
    return (self.a == other.a and self.b == other.b and self.c == other.c or
            self.a == other.b and self.b == other.a and self.c == other.c) 
end

function Node:sum()
    return self.a + self.b + self.c
end

function Node:less_than(factor)
    return self.a <= factor and self.b <= factor and self.c <= factor
end

function Node:greater_than(factor)
    return self.a >= factor and self.b >= factor and self.c >= factor
end

function Node:successors()
    possible_nodes = {
        Node:new(self.a + 1, self.b, self.c),
        Node:new(self.a, self.b + 1, self.c),
        Node:new(self.a, self.b, self.c + 1)
    }

    return coroutine.wrap(function() 
        for _, node in ipairs(possible_nodes) do
            if node:valid() then
                coroutine.yield(node)
            end
        end
    end)
end

function Node:representations()
    return coroutine.wrap(function()
        coroutine.yield(self.a .. "," .. "," .. self.b .. "," .. self.c)
        coroutine.yield(self.b .. "," .. "," .. self.a .. "," .. self.c)
    end)
end

function Node:valid()
    return self.a < self.c and self.b < self.c
end

function Node:to_table()
    t = {self.a, self.b, self.c}
    table.sort(t)
    return t
end

function pyth.is_triplet(a, b, c)
    return a^2 + b^2 == c^2
end

function pyth.triplets_with(constraints)
    local seen_nodes = {}
    local result = {}
    local queue = {}

    table.insert(queue, Node:new(3, 4, 5))

    while #queue > 0 do
        local node = table.remove(queue, 1)
        local is_valid = (pyth.is_triplet(node.a, node.b, node.c) and 
            node:greater_than(constraints.min_factor or 0) and
            node:sum() == (constraints.sum or node:sum()))

        if is_valid then
            table.insert(result, node:to_table())
        end

        for successor in node:successors() do
            if successor:less_than(constraints.max_factor) then
                local previously_seen = false

                for representation in successor:representations() do
                    if seen_nodes[representation] then
                        previously_seen = true
                    end
                    seen_nodes[representation] = true
                end

                if not previously_seen then
                    table.insert(queue, successor)
                end
            end
        end
    end

    return result
end
return pyth
