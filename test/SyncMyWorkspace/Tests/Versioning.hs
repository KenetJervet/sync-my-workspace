{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies          #-}
{-# LANGUAGE TypeSynonymInstances  #-}

module SyncMyWorkspace.Tests.Versioning where

import           SyncMyWorkspace.Versioning
import           Test.Tasty
import           Test.Tasty.HUnit

data XZero

data XVersion1 = XVersion1 deriving (Show, Eq)
type instance Prototype XVersion1 = XZero
data XVersion2 = XVersion2 deriving (Show, Eq)
type instance Prototype XVersion2 = XZero
data XVersion3 = XVersion3 deriving (Show, Eq)
type instance Prototype XVersion3 = XZero

instance AtomicMigration IO XVersion1 XVersion2 where
  atomicMigrate XVersion1 = putStrLn "Migrating to XVersion2" >> return XVersion2

instance AtomicMigration IO XVersion2 XVersion3 where
  atomicMigrate XVersion2 = putStrLn "Migrating to XVersion3" >> return XVersion3


tests :: TestTree
tests = testGroup "tests of versioning"
  [ testCase "" $ do
      latest <- migrate XVersion1
      latest @=? XVersion3
  ]
