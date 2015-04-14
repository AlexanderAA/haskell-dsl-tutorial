#!/usr/bin/env runhaskell

{-| Simple DSL to describe contracts

Example 4: Evaluation with observables

-}

data Contract = Contract { name :: Name, terms :: Terms }   --  deriving Show

type Name = String

data Terms =
    Zero
    | One
    | Give Terms
    | And  Terms Terms
    | Scale Int Terms
    | When (Observable Bool) Terms
--    deriving Show

toAmount :: Time -> Terms -> Int
toAmount time One = 1
toAmount time (Scale s terms) = s * (toAmount time terms)
toAmount time (And t1 t2) = (toAmount time t1) + (toAmount time t2)
toAmount time (Give t) = (-1) * (toAmount time t)
toAmount time (When (Obs o) terms) = if (o time) 
                                            then (toAmount time terms) else 0

type Time = Integer
newtype Observable a = Obs (Time -> a)

getValue :: Observable a -> Time -> a
getValue (Obs x) time = x time


at :: Time -> Observable Bool
at t = Obs (\time -> (time == t))


konst :: a -> Observable a
konst k = Obs (\t -> k)


main = do
    print $ toAmount 0 $ (When (at 1) One)
    print $ toAmount 1 $ (When (at 1) One)
    print $ toAmount 2 $ (When (at 1) One)
    print $ toAmount 3 $ (When (at 1) One)
    
    print $ toAmount 4 $ (When (at 5) (Scale 7 One))
    print $ toAmount 5 $ (When (at 5) (Scale 7 One))
    print $ toAmount 6 $ (When (at 5) (Scale 7 One))
    