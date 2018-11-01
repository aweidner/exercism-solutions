module PerfectNumbers (classify, Classification(..)) where

data Classification = Deficient | Perfect | Abundant deriving (Eq, Show)

classify :: Int -> Maybe Classification
classify n
    | n < 1 = Nothing
    | aliquot n == n = Just Perfect
    | aliquot n > n = Just Abundant
    | aliquot n < n = Just Deficient
    | otherwise = Nothing

aliquot :: Int -> Int
aliquot n = foldl (+) 0 [x | x <- [1 ..  n - 1], n `mod` x == 0]
