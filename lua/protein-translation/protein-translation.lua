local translate = {}

local codons = {
    UAA='STOP',
    UAG='STOP',
    UGA='STOP',
    AUG='Methionine',
    UUU='Phenylalanine',
    UUC='Phenylalanine',
    UUA='Leucine',
    UUG='Leucine',
    UCU='Serine',
    UCC='Serine',
    UCA='Serine',
    UCG='Serine',
    UAU='Tyrosine',
    UAC='Tyrosine',
    UGU='Cysteine',
    UGC='Cysteine',
    UGG='Tryptophan'
}

function translate.codon(codon)
    return assert(codons[codon])
end

function translate.rna_strand(strand)
    local result = {}
    for codon in strand:gmatch("...") do
        translation = translate.codon(codon)
        if translation == "STOP" then
            break
        end
        table.insert(result, translation)
    end
    return result
end

return translate
