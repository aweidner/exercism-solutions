local function clear_table(table, length)
    for i = 1, length do
        table[i] = nil
    end
    return table
end

local CircularBuffer = {}

function CircularBuffer:new(length)
    local internal_buffer = clear_table({}, length)

    local new_buffer = {
        length = length,
        buffer = internal_buffer,
        write_pointer = 1,
        read_pointer = 1
    }

    setmetatable(new_buffer, self)
    self.__index = self
    return new_buffer
end

function CircularBuffer:increment(pointer)
    if pointer + 1 > self.length then
        return 1
    end
    return pointer + 1
end

function CircularBuffer:read(entry)
    assert(self.buffer[self.read_pointer], "buffer is empty")
    local result = self.buffer[self.read_pointer]
    self.buffer[self.read_pointer] = nil
    self.read_pointer = self:increment(self.read_pointer)
    return result
end

function CircularBuffer:write(entry)
    assert(not self.buffer[self.write_pointer], "buffer is full")
    self:forceWrite(entry)
end

function CircularBuffer:clear()
    clear_table(self.buffer, self.length)
    self.write_pointer = 1
    self.read_pointer = 1
end

function CircularBuffer:forceWrite(entry)
    if entry == nil then
        return
    end

    local did_overwrite = not(not self.buffer[self.write_pointer])
    local oldest_overwritten = self.write_pointer == self.read_pointer

    if did_overwrite and oldest_overwritten then
        self.read_pointer = self:increment(self.read_pointer)
    end

    self.buffer[self.write_pointer] = entry
    self.write_pointer = self:increment(self.write_pointer)
end

return CircularBuffer
