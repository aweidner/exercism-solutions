module DNA (toRNA) where

toRNA :: String -> Maybe String
toRNA xs = mapM complement xs

complement :: Char -> Maybe Char
complement 'G' = Just 'C'
complement 'C' = Just 'G'
complement 'T' = Just 'A'
complement 'A' = Just 'U'
complement x = Nothing 
