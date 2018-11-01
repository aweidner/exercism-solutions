module Raindrops (convert) where

convert :: Int -> String
convert n = pling(n)

pling :: Int -> String
pling n
    | mod n 3 == 0 = "Pling" ++ plang(n)
    | otherwise = plang(n)

plang :: Int -> String
plang n
    | mod n 5 == 0 = "Plang" ++ plong(n)
    | otherwise = plong(n)

plong :: Int -> String
plong n
    | mod n 7 == 0 = "Plong"
    | (mod n 3 /= 0) && (mod n 5 /= 0) && (mod n 7 /= 0) = show(n)
    | otherwise = ""

