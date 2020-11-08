# Formative 2

## Remarks

- Copy the file `Formative2-Template.hs` to a new file called `Formative2.hs`
  and write your solutions in `Formative2.hs`. Don't change the header of this
  file, _including the module declaration_, and, moreover, _don't_ change the
  type signature of any of the given functions for you to complete.
- Solve the exercises below in the file `Formative2.hs`.
- In this assignment you are allowed to use Haskell library functions that are
  available in CoCalc. Look it up at [Hoogle](https://hoogle.haskell.org/).
- Run the pre-submit script to check for any (compilation) errors **before**
  submitting by running in the terminal:
  ```bash
  $ ./presubmit.sh Formative2
  ```
- Submit your file `Formative2.hs` via Canvas at
  https://canvas.bham.ac.uk/courses/46061/assignments/252199.

## Exercises

### Exercise 0: Getting Started

Copy the file `Formative2-Template.hs` into a new file `Formative2.hs`.

### Exercise 1: Tuples

Implement a function

```haskell
toTuple :: (c -> a) -> (c -> b) -> c -> (a,b)
```
such that
```hs
fst . toTuple f g = f
snd . toTuple f g = g
```

### Exercise 2: Mapping on Lists

Implement a function

```haskell
mapList :: [a -> b] -> [a] -> [b]
```
that applies every function in the input list to every element, e.g.,
```hs
mapList [(* 10), (+ 2)] [1,2] = [10,20,3,4]
```

### Exercise 3: Cashier's Algorithm

Given currency denominations: 1, 5, 10, 25, 50, 100, and an amount, compute the selection of coins totalling the amount, that uses the fewest number of coins. At each iteration, add the coin of the largest value that does not take us past the amount to be paid. Your implementation has to be flexible so that it can take any list of denominations such as 1, 5, 10, 100 (instead) and find the solution.

More formally, given a list of coins `[c1,..,cn]` and an amount `a` we shall find a list `[a1,..,an]` of integers such that `c1*a1 + .. + cn*an = a` - but not just any - we want to minimize the number of coins given: `a1 + .. + an`.

For example: 34 cents
```hs
> coinChange 34 [1, 5, 10, 25, 50, 100]
[4,1,0,1,0,0]
> coinChange 34 [1, 5, 10, 100]
[4,0,3,0]
```

For example: $2.89, taken to be 289 cents
```hs
> coinChange 289 [1, 5, 10, 25, 50, 100]
[4,0,1,1,1,2]
> coinChange 289 [1, 5, 10, 25, 100]
[4,0,1,3,2]
> coinChange 289 [1, 5, 10, 100]
[4,1,8,2]
```

The function type should look like:
```haskell
coinChange :: Integer -> [Integer] -> [Integer]
```

### Exercise 4: Trees

This is regarding the material of Week 6.

Consider the datatype
```haskell
data Tree a b = Leaf a | Node b [Tree a b]
     deriving (Show,Eq)
```

Write functions
```haskell
leavesAndNodes :: Tree a b -> ([a],[b])
treeMap        :: (a -> c) -> (b -> d) -> Tree a b -> Tree c d
treeFold'      :: (a -> c) -> (b -> [c] -> c) -> Tree a b -> c -- *stretcher*
treeFold       :: (a -> c -> c) -> (b -> [c] -> c) -> c -> Tree a b -> c -- *stretcher*
```
explained below:
* The function `leavesAndNodes` should collect labels at leaves (of type `a`) and labels at the nodes (of type `b`)  in a pair of lists.
  For instance:
  ```hs
  leavesAndNodes (Node "abc" [Node "x" [],Leaf 1,Leaf 2,Leaf 3]) = ([1,2,3],["abc","x"])
  ```

* The function `treeMap` is explained by the following examples:
  ```hs
  treeMap (+2) (+5) (Node 7 [Leaf 6]) = Node 12 [Leaf 8]
  treeMap (+2) (|| True) (Node False [Leaf 6]) = Node True [Leaf 8]
  treeMap (+2) (&& True) (Node False [(Node True [Leaf 3]), (Node False [Leaf 7])]) = Node False [Node True [Leaf 5],Node False [Leaf 9]]
  treeMap even (&& True) (Node False [(Node True [Leaf 3]), (Node False [Leaf 7])]) = Node False [Node True [Leaf False],Node False [Leaf False]]
  ```

  The idea is that `treeMap f g` applies the function `f` to the labels at the leaves, and the function `g` to the labels as the nodes.

* (**Stretcher 🔥**) The function `treeFold'` is harder to both understand and implement. Here is an example (with the root at the top). With `a=Number` and `b=String`, consider the following tree:
  ```hs
  data Number = One | Two | Three | Four

               "Add"
               /     \ 
  t =         /       \
           "Add"       "Mul"
            / \    /     |    \
          One Two Three Four Two 
    = Node "Add" [Node "Add" [Leaf One , Leaf Two], Node "Mul" [Leaf Three , Leaf Four , Leaf Two]]
  ```
  which represents the expression `(1+2)+(3*4*2)`, whose value is `27` . Consider also, with `c = Int`, the functions
  ```hs
  f :: Number -> Int
  f One   = 1
  f Two   = 2
  f Three = 3
  f Four  = 4

  g :: String -> [Int] -> Int
  g "Add" xs = add xs
  g "Mul" xs = product xs
  g _     _  = undefined
  ```
  Then you should get `treeFold' f g t = 27`.

* (**Stretcher 🔥**) The function `treeFold` generalizes `treeFold'` with an extra parameter. We leave to you to try to figure out a sensible implementation. So this is a more exploratory question.

### Exercise 5 (Stretcher 🔥): Primitive Recursion Schemes

We can define the natural numbers as an inductive type as follows:

```haskell
data Nat = Zero | Suc Nat
```

The idea is that `Zero` denotes `0` and `Suc n` denotes `n + 1`. Using this
notation, we write down the number `5` as follows:

```hs
five = Suc (Suc (Suc (Suc (Suc Zero))))
```

For convenience, we define some functions that allow us to convert `Nat` to
`Int` and vice versa.

```haskell
natToInt :: Nat -> Int
natToInt Zero    = 0
natToInt (Suc n) = 1 + natToInt n
```

Notice, by the way, that `natToInt` is an [injection][1].

```haskell
absoluteValue :: Int -> Nat
absoluteValue = absoluteValueRec . abs
  where
    absoluteValueRec :: Int -> Nat
    absoluteValueRec 0 = Zero
    absoluteValueRec n = Suc (absoluteValue (pred n))
```

Let's also tell the compiler to display elements of `Nat` using their decimal
representations for further convenience:

```haskell
instance Show Nat where

  show n = "Nat " ++ show (natToInt n)
```

This will enable `five`, for instance, to be printed as `Nat 5`.

Now, we can get started with the exercise. Think about how you would define a
function on `Nat` by recursion. Let's take as example the function that
multiples its argument by two:

```hs
double :: Nat -> Nat
double Zero    = Zero                 -- Equation †
double (Suc n) = Suc (Suc (double n)) -- Equation ‡
```

You are encouraged to load the functions defined up until this point and
experiment with them using `ghci`.

We define almost all recursive functions on `Nat` as we did in the example of
`double`, that is, by writing down the computations that must take place:

  1. in the *base case* (`n = 0`), and
  2. in the *inductive case (`n > 0`)*,

and then writing an equation for each. In the `double` example, we have Equation
† for (1) and Equation ‡ for (2).

Notice, however, that the computation that must take place in the inductive case
must have the ability to refer to (a) the argument on which we are doing
recursion as well as (b) the result of the recursive call. The computation in
Equation ‡ only make use of (b) but take note of the fact that it could also
refer to (a).

Your task in this exercise is to write a higher-order function that captures
this **scheme** of defining a function by recursion on `Nat`. This is sometimes
called the [primitive recursion][0] scheme of the natural numbers.

This function you implement should be called `natrec` and must have the type:

```haskell
natrec :: (Nat -> a -> a) -> a -> Nat -> a
```

The first argument of `natrec` is for the computation that will take place in
the inductive step. As this computation has access to the argument (as
mentioned) on which we are doing recursion as well as the result of the
recursive call, it is a function of two arguments. In other words, it will
look like

```hs
  \ (Suc n) r -> ...
```

where `r` denotes the result of the recursive call and `Suc n` is the argument
on which we are doing induction. The second argument of `natrec` is an
expression that expresses the computation that will take place in the inductive
case.

Although this concept of a recursion scheme might seem a bit strange, it is
quite similar to mapping or folding over lists: `map` and `foldr`/`foldl`
capture certain ways of doing recursion on lists whereas `natrec` captures a
certain way of doing recursion on the natural numbers.

Using your `natrec`, defining `double` should be a one-liner:

```hs
double' :: Nat -> Nat
double' = natrec (\_ r -> Suc (Suc r)) Zero
```

Here are some more examples of using `natrec`

1. a `range` function that takes some `n` and returns the list `[n..0]` using
   `natrec` as:

   ```hs
   range :: Nat -> [Nat]
   range = natrec (\n r -> (Suc n) : r) [Zero]
   ```

1. Addition on natural numbers:

   ```hs
   add :: Nat -> Nat -> Nat
   add = natrec (\m r -> \n -> Suc (r n)) id
   ```

1. Even/odd tests:

   ```hs
   even :: Nat -> Bool
   even = natrec (\_ r -> not r) True
   ```

   ```hs
   odd :: Nat -> Bool
   odd = natrec (\_ r -> not r) False
   ```
1. Sum of all numbers up to some `n`:

   ```hs
   sumUpTo :: Nat -> Nat
   sumUpTo = natrec (\n r -> (Suc n) `add` r) Zero
   ```

Another interesting exercise (**stretcher 🔥🔥🔥**) would be to define a
function `gcd m n` that computes the greatest common divisor of `m` and `n`. We
will not provide feedback for this.

[0]: https://plato.stanford.edu/entries/recursive-functions/#OrigPrimRecu
[1]: https://git.cs.bham.ac.uk/ahrensb/fp-learning-2020-2021/-/blob/master/LectureNotes/Sections/data.md#type-retracts
