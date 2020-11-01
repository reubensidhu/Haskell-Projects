-- setting the "warn-incomplete-patterns" flag asks GHC to warn you
-- about possible missing cases in pattern-matching definitions
{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}

-- see https://wiki.haskell.org/Safe_Haskell
{-# LANGUAGE Safe #-}

-- You should copy this file to a new file called Summative1.hs and write your
-- solutions in that file.

-- A "fresh" template can be found at:
-- https://git.cs.bham.ac.uk/ahrensb/fp-learning-2020-2021/-/tree/master/Assignments/Summative1/Summative1-Template.hs

module Summative1 (catYrs , golfScorer , majority , luhn , bankCardNumbers , encrypt) where

import Data.Char

catYrs :: Integer -> Integer
catYrs n | n<=0       = 0
         | n==1       = 15
         | n==2       = 24
         | otherwise  = 24 + 4 * (n - 2)

golfScorer :: Integer -> Integer -> Integer
golfScorer p s | s==1     = 5
               | (p-s)>=2 = 4
               | (p-s)==1 = 3
               | (p-s)==0 = 2
               | (s-p)==1 = 1
               | otherwise = 0

majority :: (Bool,Bool,Bool) -> Bool
majority (True,True,_) = True
majority (True,_,True) = True
majority (_,True,True) = True
majority (_,_,_) = False

luhn :: [Int] -> Bool
luhnDouble :: Int -> Int
luhnDouble n = if n*2>9 then (n*2)-9 else n*2
doubleEveryOther :: [Int] -> [Int]
doubleEveryOther [] = []
doubleEveryOther (x : []) = [x]
doubleEveryOther (x:y:xys) = (x : luhnDouble y : doubleEveryOther xys)
luhn [] = False
luhn (x : []) = if mod x 10 == 0 then True else False
luhn (x:y:xys) = if mod (sum(doubleEveryOther(reverse(x:y:xys)))) 10 == 0 then True else False

bankCardNumbers :: Int -> [[Int]]
combOfDigits :: Int -> [[Int]]
combOfDigits 0 = return []
combOfDigits n = do
    x <- [0..9]
    xs <- combOfDigits (n - 1)
    return (x : xs)
bankCardNumbers x = [a | a <- combOfDigits x, luhn a] 

let2int :: Char -> Int
let2int c = ord c - ord 'A'

int2let :: Int -> Char
int2let n = chr (ord 'A' + n)

str2int :: String -> [Int]
str2int c = [if isUpper a then (let2int a) else 0| a <- c]

int2str :: [Int] -> String 
int2str c = [int2let a | a <-c]

duplicate :: String -> String -> String
duplicate str1 str2 | length (str1) < length (str2) = take (length (str2)) (concat (replicate (length(str2)) str1))
                    | length (str1) == length (str2) = str1
                    | otherwise = take (length (str2)) str1

encrypt :: String -> String -> String
encrypt x y = int2str [mod a 26 | a <- zipWith (+) (str2int(duplicate x y)) (str2int y)]



