A haskell program that creates an unsolvable "FOX" word-search puzzle

### How to use

- Download FOX.exe [here](https://github.com/Awelson/FOX/releases/tag/v0.1.0.0)
    - or (if you have Haskell installed) build the project yourself with `cabal build FOX`
- Navigate to the directory where FOX.exe is stored with command prompt
- Type in `FOX n` for any positive integer `n` and press enter

Example :

```
> FOX 10

x x o o f o f x o x
x f x f o f o o o x
x o o x o o o x o x
x o o f x f x o o f
f x o x x f x o o o
o o f x x f f f x f
f x o x f o o o f o
f x f f f f o o f f
o x x x f f o o o o
f x x x o x o o o f

f: 29% 
o: 40%
x: 31%
```

> I also made it print the % composition of each letter in the generated puzzle. I was aiming to make the program as balanced as possible, i.e. ~33% composition for each letter.