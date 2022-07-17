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
