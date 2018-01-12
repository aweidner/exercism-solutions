local function zellar_year(year, month)
    if month <= 2 then
        return year - 1
    end
    return year
end

local function zeller_month(month)
    if month <= 2 then
        return month + 12
    end
    return month
end

local function is_leap_year(year)
    return year % 4 == 0 and not (year % 100 == 0 and year % 400 ~= 0)
end

local function last_day_of_month(year, month)
    if month == 2 then
        if is_leap_year(year) then
            return 29
        end
        return 28
    elseif month == 1 or month == 3 or month == 5 or month == 7 or month == 8 or month == 10 or month == 12 then
        return 31
    else
        return 30
    end
end

return function(description)
    local zellar_days = {
        Saturday = 0,
        Sunday = 1,
        Monday = 2,
        Tuesday = 3,
        Wednesday = 4,
        Thursday = 5,
        Friday = 6
    }

    local last = last_day_of_month(description.year, description.month)

    local bounds = {
        first = {1, 7},
        second = {8, 14},
        third = {15, 21},
        fourth = {22, 28},
        fifth = {29, 31},
        teenth = {13, 19},
        last = {last - 6, last}
    }

    local Y = zellar_year(description.year, description.month)
    local m = zeller_month(description.month)
    local h = zellar_days[description.day]

    local kludge = ((13 * (m + 1)) // 5) + Y + (Y // 4) - (Y // 100) + (Y // 400)

    for day_of_month = bounds[description.week][1], bounds[description.week][2] do
        if (day_of_month + kludge) % 7 == h then
            return day_of_month
        end
    end
end
