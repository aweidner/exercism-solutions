module Diamond (diamond) where

import Data.Char (ord)

diamond :: Char -> Maybe [String]
diamond character = Just
    ((subRows character) ++
     [mainRow character] ++
     (reverse (subRows character)))

subRows :: Char -> [String]
subRows character
    | character < 'B' = []
    | otherwise = init [subRow (diamondWidth character) current | current <- ['A'.. character]]

subRow :: Int -> Char -> String
subRow width 'A' = outerSpaces ++ ['A'] ++ outerSpaces 
    where outerSpaces = spaces (width `quot` 2)
subRow width character = outerSpaces ++ c ++ innerSpaces ++ c ++ outerSpaces 
    where c = [character]
          outerSpaces = spaces (width `quot` 2 - (distance character))
          innerSpaces = spaces (width - 2 - (2 * length outerSpaces)) 

spaces :: Int -> String
spaces n = [1 .. n] >> " "

diamondWidth :: Char -> Int
diamondWidth character = distance character * 2 + 1

distance :: Char -> Int
distance character = ord character - ord 'A'

mainRow :: Char -> String
mainRow 'A' = "A" 
mainRow character = [character] ++ (spaces (diamondWidth character - 2)) ++ [character]
