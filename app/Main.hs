module Main where

import Data.Matrix
import Data.Maybe
import System.Random.Shuffle (shuffleM)
import Control.Monad (foldM)
import Control.Monad.Random (evalRandIO)
import System.Environment (getArgs)
import Text.Read (readMaybe)
import System.Exit (exitFailure)

getElementsSafe :: Matrix a -> [(Int, Int)] -> [a]
getElementsSafe m coords = mapMaybe (\(row, col) -> safeGet row col m) coords

tryLetters :: Matrix Char -> (Int, Int) -> String -> IO (Matrix Char)
tryLetters m _ [] = return $ m 
tryLetters m (i, j) (c:cs) = do
    let mm = setElem c (i, j) m
    let dir1 = getElementsSafe mm [(i-2,j),(i-1,j),(i,j)]
    let dir2 = getElementsSafe mm [(i-2,j-2),(i-1,j-1),(i,j)]
    let dir3 = getElementsSafe mm [(i,j-2),(i,j-1),(i,j)]
    let dir4 = getElementsSafe mm [(i+2,j-2),(i+1,j-1),(i,j)]
    let mall = dir1 == "fox" || dir1 == "xof" || dir2 == "fox" || dir2 == "xof" || dir3 == "fox" || dir3 == "xof" || dir4 == "fox" || dir4 == "xof" 
    if mall 
        then tryLetters m (i, j) cs
        else return $ mm

acc :: Matrix Char -> (Int, Int) -> IO (Matrix Char)
acc m (i, j) = do
    scrambled <- evalRandIO $ shuffleM "fox" :: IO (String)
    tryLetters m (i, j) scrambled

main :: IO ()
main = do
    args <- getArgs
    case args of
        (arg:_) -> case (readMaybe arg :: Maybe Int) of
            Just n  -> do
                let size = n
                let m = matrix size size $ \(_,_) -> 'z'
                let list = [(j, i) | i <- [1..size], j <- [1..size]]
                m' <- foldM acc m list
                let pretty = map (\x -> unwords (map (:[]) x)) (toLists m')
                -- let pretty = unwords (map (:[]) (toList m'))
                putStr (unlines pretty)
            Nothing -> do
                putStrLn "Not a valid integer"
                exitFailure
        [] -> do
            putStrLn "No arguments provided"
            exitFailure
    