module CatBox
  ( Equation(..)
  )
  where

import Prelude

import Data.Foldable (foldMap)
import Data.List.Types (NonEmptyList)

data Equation = Cat | Box (NonEmptyList Equation)

instance showEquation :: Show Equation where
  show Cat = "😼"
  show (Box equations) = "[" <> foldMap show equations <> "]"

instance eqEquation :: Eq Equation where
  eq Cat Cat = true
  eq (Box eqs1) (Box eqs2) = eq eqs1 eqs2
  eq _ _ = false
