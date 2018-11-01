module Acronym (abbreviate) where

import Data.List.Split (splitOneOf)
import Data.Char (isUpper, toUpper)

abbreviate :: String -> String
abbreviate xs = (map toUpper . concat . map firstAndCaps) (splitOneOf " -" xs)

firstAndCaps :: String -> String
firstAndCaps (head:xs)
    | all isUpper xs = [head]
    | otherwise = [head] ++ (filter isUpper xs)
