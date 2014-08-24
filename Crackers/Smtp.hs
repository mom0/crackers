module Crackers.Smtp (
    smtpOk,
    creds
)

where

import Network.HaskellNet.SMTP
import Network.HaskellNet.SMTP.SSL
import Network.HaskellNet.Auth (AuthType(LOGIN))

smtpOk :: Int -> Bool
smtpOk = (== 235)

creds :: String -> String -> String -> IO (String, Bool)
creds host username password = doSMTPSTARTTLS host $ \c -> do
    (rsp, _) <- sendCommand c $ AUTH LOGIN username password
    if smtpOk rsp then return (password, True) else return (password, False)
