module Queens (boardString, canAttack) where

boardString :: Maybe (Int, Int) -> Maybe (Int, Int) -> String
boardString white black = placeQueen white 'W' (placeQueen black 'B' generateBoard)

generateBoard :: String
generateBoard = unlines [ "_ _ _ _ _ _ _ _"
                        , "_ _ _ _ _ _ _ _"
                        , "_ _ _ _ _ _ _ _"
                        , "_ _ _ _ _ _ _ _"
                        , "_ _ _ _ _ _ _ _"
                        , "_ _ _ _ _ _ _ _"
                        , "_ _ _ _ _ _ _ _"
                        , "_ _ _ _ _ _ _ _" ]

placeQueen :: Maybe (Int, Int) -> Char -> String -> String
placeQueen Nothing q board = board
placeQueen (Just (y, x)) q board = (joinBoardAround (splitAt queenPosition board) q) where
                                queenPosition = y * 16 + (2 * x)

joinBoardAround :: (String, String) -> Char -> String
joinBoardAround (first, last) piece = first ++ [piece] ++ (drop 1 last)

canAttack :: (Int, Int) -> (Int, Int) -> Bool
canAttack queenA queenB = onSameRank || onSameFile || onDiagonal where
                            onSameRank = sameRank queenA queenB
                            onSameFile = sameFile queenA queenB
                            onDiagonal = diagonal queenA queenB

sameRank :: (Int, Int) -> (Int, Int) -> Bool
sameRank (x1, _) (x2, _) = x1 == x2

sameFile :: (Int, Int) -> (Int, Int) -> Bool
sameFile (_, y1) (_, y2) = y1 == y2

diagonal :: (Int, Int) -> (Int, Int) -> Bool
diagonal (x1, y1) (x2, y2) = abs (y1 - y2) `div` abs (x1 - x2) == 1
