module Crackers.Gmail (
    gmailCredsWork
)

where

import Crackers.Smtp

gmailCredsWork :: String -> String -> IO (String, Bool)
gmailCredsWork = credsWork "smtp.gmail.com"
