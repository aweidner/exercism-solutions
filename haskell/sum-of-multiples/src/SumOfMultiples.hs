module SumOfMultiples (sumOfMultiples) where

import Data.List (nub)

sumOfMultiples :: [Integer] -> Integer -> Integer
sumOfMultiples factors limit = (sum . nub . concat) listOfFactorLists
    where listOfFactorLists = map (factorList limit) factors

factorList :: Integer -> Integer -> [Integer]
factorList _ 0 = []
factorList limit factor = [factor, factor * 2 .. limit - 1]
