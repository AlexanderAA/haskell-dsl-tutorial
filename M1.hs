#!/usr/bin/env runhaskell

{-| Simple DSL to describe contracts

Example 1: Data types

-}


data Contract = Contract { name :: Name, terms :: Terms }     deriving Show

type Name = String

data Terms =
    Zero
    | One                 -- ^ Get "one dollar" or "one penny"
    | Give Terms          -- ^ Give
    | And  Terms Terms
    deriving Show



main = do
    
    print $ One
    print $ One `And` (Give One)
    print $ One `And` (Give (Give One))
    print $ One `And` One `And` (Give (Give (One `And` One `And` One)))
    
    print $ Contract "Sample contract" One
    print $ Contract { name = "Sample contract", terms = One }
