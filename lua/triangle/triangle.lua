return {
    kind = function(a, b, c) 
        local temp_table = table.pack(a, b, c) 
        table.sort(temp_table)
        a, b, c = table.unpack(temp_table) 

        assert(a > 0, "Input Error")
        assert(b > 0, "Input Error")
        assert(c > 0, "Input Error")
        assert(a + b > c, "Input Error")

        if a == b and b == c then
            return "equilateral"
        elseif a == b or b == c then
            return "isosceles"
        else
            return "scalene"
        end
    end
}
