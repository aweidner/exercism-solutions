local brackets = {}

function brackets.valid(contents)
    local starts = {["{"]="}", ["("]=")", ["["]="]"}
    local ends = {["}"]="{", [")"]="(", ["]"]="["}

    local stack = {} 

    for i = 1, #contents do
        brace = contents:sub(i, i)
        if starts[brace] then
            table.insert(stack, brace)
        elseif ends[brace] then
            start_brace = table.remove(stack, #stack) 
            if start_brace ~= ends[brace] then
                return false
            end
        end
    end

    return #stack == 0
end

 return brackets
