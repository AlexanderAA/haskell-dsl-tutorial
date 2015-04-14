#!/usr/bin/env runhaskell

{-| Simple DSL to describe contracts

Example 2: Evaluation

-}

data Contract = Contract { name :: Name, terms :: Terms }     deriving Show

type Name = String

data Terms =
    Zero
    | One
    | Give Terms
    | And  Terms Terms
    | Scale Int Terms
    deriving Show

toAmount :: Terms -> Int
toAmount One = 1
toAmount (Scale s t) = s * (toAmount t)
toAmount (And t1 t2) = (toAmount t1) + (toAmount t2)
toAmount (Give t) = (-1) * (toAmount t)

main = do

    print $ toAmount $ One `And` (Give One)
    print $ toAmount $ (Scale 7 One) `And` (Give One)
    print $ toAmount $ Scale 5 $ (Scale 7 One) `And` (Give One)
