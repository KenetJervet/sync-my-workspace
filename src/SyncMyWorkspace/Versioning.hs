{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE GADTs                  #-}
{-# LANGUAGE MultiParamTypeClasses  #-}
{-# LANGUAGE TypeFamilies           #-}
{-# LANGUAGE UndecidableInstances   #-}

module SyncMyWorkspace.Versioning where

class Versioned v

data family Prototype :: * -> *

class (Monad m, Prototype v1 ~ Prototype v2) => Migration m v1 v2 | v1 -> v2 where
  migrate :: v1 -> m v2

instance (Monad m, Migration m v1 v2, Migration m v2 v3) => Migration m v1 v3 where
  migrate v1 = (migrate v1 :: m v2) >>= migrate
