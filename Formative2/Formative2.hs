-- setting the "warn-incomplete-patterns" flag asks GHC to warn you
-- about possible missing cases in pattern-matching definitions
{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}

-- see https://wiki.haskell.org/Safe_Haskell
{-# LANGUAGE Safe #-}

-- You should copy this file to a new file called Formative2.hs and write your
-- solutions in that file.

-- A "fresh" template can be found at:
-- https://git.cs.bham.ac.uk/ahrensb/fp-learning-2020-2021/-/tree/master/Assignments/Formative2/Formative2-Template.hs

module Formative2 (toTuple , mapList , coinChange , leavesAndNodes , treeMap , treeFold' , treeFold , natrec) where

import Types

toTuple :: (c -> a) -> (c -> b) -> c -> (a,b)
toTuple f g x = (f x, g x)

mapList :: [a -> b] -> [a] -> [b]
mapList fs xs = [f x | x <- xs, f <- fs]

func :: Integer -> [Integer] -> [Integer]
func _ [] = []
func 0 _ = [0]
func i (x:xs) = (div i x):func (i-((div i x)*x)) xs 

coinChange :: Integer -> [Integer] -> [Integer]
coinChange i xs = reverse (func i (reverse xs))

leavesAndNodes :: Tree a b -> ([a],[b])
leavesAndNodes t = toTuple (flattena ) (flattenb ) t

flattena :: Tree a b -> ([a])
flattena (Leaf a) = [a]
flattena (Node b t) = concat [flattena u | u <- t]

flattenb :: Tree a b -> ([b])
flattenb (Leaf a) = []
flattenb (Node b t) = [b] ++ concat [flattenb u | u <- t]

treeMap :: (a -> c) -> (b -> d) -> Tree a b -> Tree c d
treeMap f g (Leaf a) = Leaf (f a)
treeMap f g (Node b t) = Node (g b) [treeMap f g u | u <- t]

treeFold' :: (a -> c) -> (b -> [c] -> c) -> Tree a b -> c -- *stretcher*
treeFold' = undefined

treeFold :: (a -> c -> c) -> (b -> [c] -> c) -> c -> Tree a b -> c -- *stretcher*
treeFold = undefined

natrec :: (Nat -> a -> a) -> a -> Nat -> a -- *stretcher*
natrec = undefined
