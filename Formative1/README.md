# Formative assignment 1


- Copy the file `Formative1-Template.hs` to a new file called `Formative1.hs`.
- Solve the exercises below in the file `Formative1.hs`.
- Run the pre-submit script to check for any (compilation) errors **before** submitting by running in the terminal:
```bash
$ ./presubmit.sh Formative1
```
- Submit your file `Formative1.hs` via Canvas at https://canvas.bham.ac.uk/courses/46061/assignments/252197 .
- You also require the file `Types.hs` to be in the same directory as `Formative1.hs`. The file `Types.hs` should **not** be modified, and should **not** be submitted on Canvas.


0. Copy the file `Formative1-Template.hs` to a new file `Formative1.hs`.

1. Write a function 
```haskell
capitalized :: [Char] -> Bool
```
that takes a word (as a string) and returns `True` if the first character is a capital letter, and `False` otherwise. 
For example:
```hs
> capitalized "Hello" 
True 
> capitalized "world" 
False
```
On the empty list, the function should return `False`.

Use the function `elem` from the prelude, and the fact that `Char` is an instance of `Enum`.

2. A year is a leap year if it is divisible by 4, except if it is divisible by 100, in which case it is not a leap year.
There is one exception to the exception: if a year is divisible by 400, it is a leap year.

Write a Haskell function 
```haskell
isLeapYear :: Int -> Bool
``` 
that computes if a given year is a leap year.

3. We classify cars into categories according to their gas usage, measured in liters per 100 kilometers.
Consider
```haskell
data Classification = Low | Medium | High | SuperHigh deriving (Show)
```
(The `deriving (Show)` is there so that Haskell can print classifications when you're testing your program in the terminal. We will discuss this in more detail later.)

Write a function 
```haskell
gasUsage :: (Fractional a, Ord a) => a -> Classification
``` 
according to the table

| Gas Usage g        | g < 3 | 3 <= g < 5 |  5 <= g < 7 | 7 <= g    |
|--------------------|-------|------------|-------------|-----------|
| Classification     | Low   | Medium     | High        | SuperHigh |


4. (From "Programming in Haskell", Section 4.8 "Exercises", Exercise 8)

The Luhn algorithm is used to check bank card numbers for simple errors such as mistyping a digit, and proceeds as follows:
- consider each digit as a separate number; 
- moving left, double every other number from the second last; 
- subtract 9 from each number that is now greater than 9; 
- add all the resulting numbers together; 
- if the total is divisible by 10, the card number is valid. 

See also the [Wikipedia entry on the Luhn algorithm](https://en.wikipedia.org/wiki/Luhn_algorithm).

Define a function 
```haskell
luhnDouble :: Int -> Int
``` 
that doubles a digit and
subtracts 9 if the result is greater than 9. For example: 
```hs
> luhnDouble 3 
6 
> luhnDouble 6 
3 
```
Using `luhnDouble` and the integer remainder function `mod`, define a function
```haskell
luhn :: Int -> Int -> Int -> Int -> Bool
```
that decides if a four digit bank card number is valid (according to the Luhn algorithm described above). 
For example: 
```hs
> luhn 1 7 8 4 
True 
> luhn 4 7 8 3 
False 
```

5. Run the pre-submit script to check for any (compilation) errors **before** submitting by running in the terminal:
```bash
$ ./presubmit.sh Formative1
```
