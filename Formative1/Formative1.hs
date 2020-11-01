-- setting the "warn-incomplete-patterns" flag asks GHC to warn you
-- about possible missing cases in pattern-matching definitions
{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}

-- see https://wiki.haskell.org/Safe_Haskell
{-# LANGUAGE Safe #-}


-- a "fresh" template can be found at
-- https://git.cs.bham.ac.uk/ahrensb/fp-learning-2020-2021/-/tree/master/Assignments/Formative1/Formative1-Template.hs


module Formative1 (capitalized , isLeapYear , gasUsage , luhnDouble , luhn) where

import Types

capitalized :: [Char] -> Bool
capitalized xs | xs == []                  = False
               | elem (head xs) ['A'..'Z'] = True
               | otherwise                 = False



isLeapYear :: Int -> Bool
isLeapYear n | (mod n 400) == 0 = True
             | (mod n 100) == 0 = False
             | (mod n 4) == 0   = True
             | otherwise        = False


gasUsage :: (Fractional a, Ord a) => a -> Classification
gasUsage a | a<3             = Low
           | 3<=a && a<5     = Medium
           | 5<=a && a<7     = High
           | otherwise       = SuperHigh


luhnDouble :: Int -> Int
luhnDouble n = if n*2>9 then (n*2)-9 else n*2


luhn :: Int -> Int -> Int -> Int -> Bool
luhn a b c d = if mod (luhnDouble a + b + luhnDouble c + d) 10 == 0 then True else False


