{-# LANGUAGE AllowAmbiguousTypes       #-}
{-# LANGUAGE ConstraintKinds           #-}
{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE FlexibleContexts          #-}
{-# LANGUAGE FlexibleInstances         #-}
{-# LANGUAGE FunctionalDependencies    #-}
{-# LANGUAGE GADTs                     #-}
{-# LANGUAGE MultiParamTypeClasses     #-}
{-# LANGUAGE TypeFamilies              #-}
{-# LANGUAGE TypeSynonymInstances      #-}
{-# LANGUAGE UndecidableInstances      #-}

module SyncMyWorkspace.Versioning where

type family Prototype p

class (Monad m, Prototype v1 ~ Prototype v2) => AtomicMigration m v1 v2 | v2 -> v1 where
  atomicMigrate :: v1 -> m v2

class (Monad m, Prototype v1 ~ Prototype v2) => Migration m v1 v2 where
  migrate :: v1 -> m v2

instance {-# OVERLAPPABLE #-} (Monad m, Migration m v1 v2, AtomicMigration m v2 v3) => Migration m v1 v3 where
  migrate v1 = do
    prevV2 <- migrate v1
    atomicMigrate prevV2

instance {-# OVERLAPPING #-} Monad m => Migration m v1 v1 where
  migrate = return

