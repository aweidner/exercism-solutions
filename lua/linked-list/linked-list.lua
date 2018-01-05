
local Node = {}

function Node:new(value)
    local new_node = {
        value = value,
        n = nil,
        p = nil
    }
    setmetatable(new_node, self)
    self.__index = self
    return new_node
end

local LinkedList = {}

function LinkedList:new()
    local new_linked_list = {head=nil, tail=nil}
    setmetatable(new_linked_list, self)
    self.__index = self
    return new_linked_list
end

function LinkedList:push(value)
    local node = Node:new(value)
    if self.tail then
        local old_tail = self.tail
        old_tail.n = node
        node.p = old_tail
    else
        self.head = node
    end
    self.tail = node
end

function LinkedList:pop()
    if self.tail then
        value = self.tail.value
        local new_tail = self.tail.p

        if new_tail then
            new_tail.n = nil
        end
        self.tail = new_tail

        return value
    end
end

function LinkedList:count()
    local node = self.head
    local count = 0
    while node do
        count = count + 1
        node = node.n
    end
    return count
end

function LinkedList:unshift(value)
    local node = Node:new(value)
    if self.head then
        local old_head = self.head
        old_head.p = node
        node.n = old_head
    else
        self.tail = node
    end
    self.head = node
end

function LinkedList:shift(value)
    if self.head then
        value = self.head.value
        local new_head = self.head.n

        if new_head then
            new_head.p = nil
        end
        self.head = new_head

        return value
    end
end

function LinkedList:delete(value)
    local node = self.head
    while node do
        if node.value == value then 
            local previous_node = node.p
            local next_node = node.n

            if next_node then
                next_node.p = previous_node
            else
                self.tail = previous_node
            end

            if previous_node then
                previous_node.n = next_node
            else
                self.head = next_node
            end

            node = next_node
        else
            node = node.n
        end
    end
end
    
return function()
    return LinkedList:new()
end
