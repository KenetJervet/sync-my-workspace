module SyncMyWorkspace.Tests.Versioning where

import Test.Tasty
import Test.Tasty.HUnit
import SyncMyWorkspace.Versioning

data XZero

data XVersion1 = XVersion1
data XVersion2 = XVersion2
data XVersion3 = XVersion3

instance Migration IO XVersion1 XVersion2 where
  migrate XVersion1 = putStrLn "Upgrading to version 2" >> return XVersion2

instance Migration IO XVersion2 XVersion3 where
  migrate XVersion2 = putStrLn "Upgrading to version 3" >> return XVersion3

tests :: TestTree
tests = testGroup "tests of versioning"
  [ testCase "" $ do
      latest <- (migrate XVersion1 :: XVersion3)
      latest @=? XVersion3
  ]
