# Summatively Assessed Assignment 1

## Remarks

- Copy the file `Summative1-Template.hs` to a new file called `Summative1.hs`. Do not edit the file `Summative1-Template.hs` as you will lose any changes made to it.
- Solve the exercises below in the file `Summative1.hs`.
- In this assignment you are allowed to use Haskell library functions that are available in CoCalc. A particularly convenient one to import for the puposes of this assignment is `Data.Char`. Look it up at [Hoogle](https://hoogle.haskell.org/).
- Run the pre-submit script to check for any (compilation) errors **before** submitting by running in the terminal:
```bash
$ ./presubmit.sh Summative1
```
- Submit your file `Summative1.hs` via Canvas at https://canvas.bham.ac.uk/courses/46061/assignments/252198 .


## Exercises

0. Copy the file `Summative1-Template.hs` into a new file `Summative1.hs`.

1. The age of a cat in human years can be calculated as follows:

| Cat age x | x <= 0 | x = 1 | x = 2 | x >=3            |
|-----------|--------|-------|-------|------------------|
| Human age | 0      | 15    | 24    | 24 + 4 * (x - 2) |

Write a function 
```haskell
catYrs :: Integer -> Integer
```
that computes the human age from the cat age.


2. Each hole in golf has an associated "Par" -- the expected number of Strokes it should take a good player to successfully complete the hole.
Once they have completed the hole, a player's total number of Strokes is compared against this Par value, and points are awarded according to the following rules:

- Taking two (or more) Strokes less than the Par is called an "Eagle", and is worth 4 points
- Taking one Stroke below Par is called a "Birdie", and is worth 3 points
- Taking the same number of Strokes as the Par is worth 2 points
- Taking one Stroke above Par is called a "Bogey", and is worth 1 point
- Taking any more Strokes than a "Bogey" is worth 0 points

There is one exception to these scoring rules:
- A "Hole-in-one" (taking exactly 1 stroke, no matter what the Par is) is always worth 5 points

Write a function 
```haskell
golfScorer :: Integer -> Integer -> Integer
```
that takes a Par as the first argument and the total number of Strokes as the second argument, and returns the amount of points awarded.

For example:
```hs
golfScorer 3 3 = 0 -- Par (same as Par)
golfScorer 5 3 = 4 -- Eagle (2+ below Par)
golfScorer 5 2 = 4 -- Eagle (2+ below Par)
golfScorer 5 1 = 5 -- Hole-in-one
```

3. Write a function 
```haskell
majority :: (Bool,Bool,Bool) -> Bool
```
that returns `True` if two or more inputs are `True`, and `False` if two or more inputs are `False`.

4. Luhn algorithm

For the solution of this question, it is convenient to use recursion.

	1. Recall the [Luhn algorithm](https://en.wikipedia.org/wiki/Luhn_algorithm) from [Formative Assignment 1](https://git.cs.bham.ac.uk/ahrensb/fp-learning-2020-2021/-/blob/master/Assignments/Formative1/README.md). Adapt the function 
	```hs
	luhn :: Int -> Int -> Int -> Int -> Bool
	```
	to a function taking a list of integers of arbitrary length.
	```haskell
	luhn :: [Int] -> Bool
	```
	Recall that the algorithm is as follows:

	 - From right to left, double every other number, starting with the second-to-last. If the double is larger than 9, subtract 9.
	   (You should use the function `luhnDouble` from `Formative1` to implement this function.)
	 - Take the sum of all the numbers.
	 - The input is a valid Luhn number if the sum is divisible by 10.
	
	
	2. Write a function
	```haskell
	bankCardNumbers :: Int -> [[Int]]
	```
	such that `bankCardNumbers n` returns a list of all Luhn valid card numbers of length `n`.

5. Ciphers

Recall the [Caesar cipher](https://git.cs.bham.ac.uk/ahrensb/fp-learning-2020-2021/-/blob/master/LectureNotes/Sections/list_comprehensions.md#extended-programming-example-the-caesar-cipher).
One of its flaws is that it uses the same shift throughout the whole encryption process.
We consider a variation with a variable shift, where the shift is determined by a keyphrase.
This variation operates **on upper-case letters only**.

- Suppose the message to be encrypted is "ILOVEMARY". 
- Pick a keyword, e.g., "AMOR".
- Repeat the keyword to obtain a keyphrase of the same length as the message to be encrypted, here "AMORAMORA".
- Now each letter of the message is encrypted **according to the Caesar cipher of its corresponding letter** in the keyphrase: 
	- 'I' is encrypted using shift factor 'A=0', i.e, as 'I'.
	- 'L' is encrypted using shift factor 'M=13', i.e., as 'X'.
	- ...
Altogether, the encryption of "ILOVEMARY" with "AMOR" yields "IXCMEYOIY".

Implement this improved cipher as a function
```haskell
encrypt :: String -> String -> String
```
such that, e.g., `encrypt "AMOR" "ILOVEMARY"` yields `"IXCMEYOIY"`.

Again, it is convenient to use recursion to solve this question.

6. Run 
```bash
$ ./presubmit.sh Summative1
```
before submitting your work.
