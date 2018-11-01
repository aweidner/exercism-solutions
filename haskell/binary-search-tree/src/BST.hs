module BST
    ( BST
    , bstLeft
    , bstRight
    , bstValue
    , empty
    , fromList
    , insert
    , singleton
    , toList
    ) where

data BST a = Nil | Node a (BST a) (BST a) deriving (Eq, Show)

bstLeft :: BST a -> Maybe (BST a)
bstLeft Nil = Nothing 
bstLeft (Node _ left _) = Just left  

bstRight :: BST a -> Maybe (BST a)
bstRight Nil = Nothing
bstRight (Node _ _ right) = Just right

bstValue :: BST a -> Maybe a
bstValue Nil = Nothing
bstValue (Node value _ _) = Just value

empty :: BST a
empty = Nil 

fromList :: Ord a => [a] -> BST a
fromList xs = foldl (\ tree x -> insert x tree) empty xs 

insert :: Ord a => a -> BST a -> BST a
insert x Nil = singleton x 
insert x (Node n left right) = if x > n then Node n left (insert x right)
                                        else Node n (insert x left) right

singleton :: a -> BST a
singleton x = (Node x) Nil Nil

toList :: BST a -> [a]
toList Nil = []
toList (Node n left right) = toList left ++ [n] ++ toList right
