module Pangram (isPangram) where

import Data.Char        (toLower)

isPangram :: String -> Bool
isPangram text = all (\ letter -> elem letter lowered) "abcdefghijklmnopqrstuvwxyz"
    where lowered = map toLower text
