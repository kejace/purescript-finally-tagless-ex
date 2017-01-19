module Main where

import AbstractFileSystem (class MonadFileSystem, FileType, cat, cd, ls)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Data.Tuple (Tuple, fst)
import FakeFileSystem (FakeFS)
import Prelude (Unit, bind, map, pure, ($))

joinFiles :: ∀ m. (MonadFileSystem m) => m String
joinFiles = do
    files <- ls
    cat $ map fst files

justLS :: forall m. (MonadFileSystem m) => m (Array (Tuple String FileType))
justLS = do
    ls

justCD :: forall m. (MonadFileSystem m) => m Unit
justCD = do
    cd "."

justCAT :: forall m. (MonadFileSystem m) => m String
justCAT = do
  cat [".", "some/other/path"]


main :: forall eff. FakeFS (Eff ( console :: CONSOLE | eff ) Unit )
main = do
    x <- (joinFiles :: FakeFS String)
    pure $ log x
