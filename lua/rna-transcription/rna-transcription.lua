local function to_rna(str)
    return str:gsub(".", {A='U', T='A', G='C', C='G'})
end

return to_rna
