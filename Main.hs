{-# LANGUAGE OverloadedStrings #-}

import Network.Wai (responseLBS, Application)
import Network.Wai.Handler.Warp (run)
import Network.HTTP.Types (status200)
import Network.HTTP.Types.Header (hContentType)
import System.Process (rawSystem)

import Database.HDBC.PostgreSQL (connectPostgreSQL')

main :: IO ()
main = do
  let port = 3000
  putStrLn $ "Listening on port " ++ show port
  run port app

app :: Application
app _ f = do
  putStrLn "Got request"
  _ <- connectPostgreSQL' "postgres://postgres:@localhost:5432/dbapi_test"
  putStrLn "Connected to postgres"
  _ <- rawSystem "sleep" ["10"]
  putStrLn "Responding"
  f $ responseLBS status200 [(hContentType, "text/plain")] "Hello world!"
