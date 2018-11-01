module Phone (number) where

import Data.Char (isDigit)

number :: String -> Maybe String
number xs
    | valid ns = Just ns
    | otherwise = Nothing
    where ns = justNumbers xs

justNumbers :: String -> String
justNumbers = filter isDigit

valid :: String -> Bool
valid = (== 11) . length 
