module Bob (responseFor) where

import Data.Char        (isLower, isAlpha, isSpace)
import Safe             (lastMay)

responseFor :: String -> String
responseFor statement
    | isYelling statement && isQuestion statement = "Calm down, I know what I'm doing!"
    | isYelling statement = "Whoa, chill out!"
    | isQuestion statement = "Sure."
    | isSilence statement = "Fine. Be that way!"
    | otherwise = "Whatever."

isYelling :: String -> Bool
isYelling statement = any isAlpha statement && not (any isLower statement)

isQuestion :: String -> Bool
isQuestion = (== Just '?') . lastNonWhitespace

lastNonWhitespace :: String -> Maybe Char
lastNonWhitespace = lastMay . filter (not . isSpace) 

isSilence :: String -> Bool
isSilence = all isSpace 
