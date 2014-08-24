module Crackers.Smtp (
    smtpOk,
    credsWork
)

where

import Network.HaskellNet.SMTP
import Network.HaskellNet.SMTP.SSL
import Network.HaskellNet.Auth (AuthType(LOGIN))

smtpOk :: Int -> Bool
smtpOk = (== 235)

credsWork :: String -> String -> String -> IO Bool
credsWork host username password = doSMTPSTARTTLS host $ \c -> do
    (rsp, _) <- sendCommand c $ AUTH LOGIN username password
    if smtpOk rsp then return (True) else return (False)
