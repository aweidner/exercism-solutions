module ETL (transform) where

import Data.Map (Map, toList, fromList)
import Data.Char (toLower)

breakup :: (k, String) -> [(k, Char)] 
breakup (k, v) = map (\c -> (k, (toLower c))) v

transform :: Map a String -> Map Char a
transform legacyData =
    (fromList
        (map (\(k,v) -> (v,k)) 
            (concat
                (map breakup
                    (toList legacyData)))))
