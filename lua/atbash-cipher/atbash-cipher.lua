return {
    encode = function(plaintext)
        plaintext = plaintext:lower():gsub("[^a-z0-9]", "")

        local plain = "abcdefghijklmnopqrstuvwxyz"
        local cipher = plain:reverse() 

        local chunks = {""}
        local chunk_index = 1

        for i = 1, #plaintext do
            ci = plain:find(plaintext:sub(i, i))
            if ci then
                chunks[chunk_index] = chunks[chunk_index] .. cipher:sub(ci, ci)
            else
                chunks[chunk_index] = chunks[chunk_index] .. plaintext:sub(i, i)
            end

            if #chunks[chunk_index] > 4 then
                chunk_index = chunk_index + 1
                chunks[chunk_index] = ""
            end
        end

        if chunks[chunk_index] == "" then
            table.remove(chunks, chunk_index)
        end

        return table.concat(chunks, " ")
    end
}
