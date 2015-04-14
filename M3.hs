#!/usr/bin/env runhaskell

{-| Simple DSL to describe contracts

Example 3: Observables

-}

type Time = Integer

newtype Observable a = Obs (Time -> a)

getValue :: Observable a -> Time -> a
getValue (Obs x) time = x time

at :: Time -> Observable Bool
at t = Obs (\time -> (time == t))

konst :: a -> Observable a
konst k = Obs (\t -> k)

main = do
    print $ getValue (at 1) 0
    print $ getValue (at 1) 1
    print $ getValue (at 1) 2
    print $ getValue (at 1) 3
