import           Test.Tasty
import qualified SyncMyWorkspace.Tests.Versioning as TVersioning

tests :: TestTree
tests = testGroup "Tests"
  [ TVersioning.tests
  ]

main :: IO ()
main = defaultMain tests
