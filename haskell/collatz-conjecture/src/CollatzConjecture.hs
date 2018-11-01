module CollatzConjecture (collatz) where

import Data.List (genericLength)

collatz :: Integer -> Maybe Integer
collatz n 
    | n < 1 = Nothing 
    | otherwise = Just (genericLength (takeWhile  (/= 1) (iterate conjecture n)))

conjecture :: Integer -> Integer
conjecture n
    | odd n = 3 * n + 1
    | otherwise = n `div` 2
