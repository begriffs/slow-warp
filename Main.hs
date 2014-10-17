{-# LANGUAGE OverloadedStrings #-}

import Network.Wai (responseLBS, Application)
import Network.Wai.Handler.Warp (run)
import Network.HTTP.Types (status200)
import Network.HTTP.Types.Header (hContentType)
import System.Process (rawSystem)

main :: IO ()
main = do
  let port = 3000
  putStrLn $ "Listening on port " ++ show port
  run port app

app :: Application
app _ f = do
  putStrLn "Got request"
  _ <- rawSystem "sleep" ["10"]
  putStrLn "Responding"
  f $ responseLBS status200 [(hContentType, "text/plain")] "Hello world!"
