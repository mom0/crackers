module Crackers.Gmail (
    gmailCreds
)

where

import Crackers.Smtp

gmailCreds :: String -> String -> IO (String, Bool)
gmailCreds = creds "smtp.gmail.com"
