
local function is_corner(board, row, col)
    return ((row == 1 and col == 1) or
            (row == #board and col == 1) or
            (row == 1 and col == #board[1]) or
            (row == #board and col == #board[1]))
end

local function mines_around(board, row, col)
    local mines = 0
    for _, row_add in ipairs({-1, 0, 1}) do
        for _, col_add in ipairs({-1, 0, 1}) do
            if (board[row + row_add]:sub(col + col_add, col + col_add) == "*" and
                not is_corner(board, row + row_add, col + col_add)) then
                mines = mines + 1
            end
        end
    end

    if mines == 0 then return " " else return mines end
end

local minesweeper = {}

function minesweeper.transform(board)
    result = {}
    table.insert(result, board[1])

    for row = 2, #board - 1 do
        new_row = "|"
        for col = 2, #board[row] - 1 do
            local character = board[row]:sub(col, col)
            assert(#board[row] == #board[1])
            assert(character == "*" or character == " ")
            if board[row]:sub(col, col) == "*" then 
                new_row = new_row .. "*"
            else
                new_row = new_row .. tostring(mines_around(board, row, col))
            end
        end
        new_row = new_row .. "|"
        table.insert(result, new_row)
    end
    
    table.insert(result, board[#board])
    return result
end

return minesweeper
