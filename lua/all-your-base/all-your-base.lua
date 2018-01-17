return {
    convert = function(source, source_base)
        assert(source_base > 1, "invalid input base")
        for _, v in pairs(source) do
            assert(v < source_base, "digit out of range")
            assert(v >= 0, "negative digits are not allowed")
        end

        return {
            to = function(target_base)
                assert(target_base > 1, "invalid output base")
            end
        }
    end
}
