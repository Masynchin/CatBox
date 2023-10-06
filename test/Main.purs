module Test.Main where

import Prelude

import CatBox (Equation(..))
import Data.Either (Either(..))
import Data.List.NonEmpty (cons, singleton)
import Effect (Effect)
import Parser (parseEquation)
import Test.Unit (suite, test)
import Test.Unit.Assert (shouldEqual)
import Test.Unit.Main (runTest)

main :: Effect Unit
main = do
  runTest do
    suite "Equation" do
      suite "show" do
        test "cat" do
          show Cat `shouldEqual` "😼"
        test "cat in box" do
          show (Box (singleton Cat)) `shouldEqual` "[😼]"
        test "cat in box and cat in nested box" do
          let nested = Box (singleton Cat)
          show (Box (cons Cat (singleton nested))) `shouldEqual` "[😼[😼]]"
        test "two cats in box" do
          let cats = cons Cat (singleton Cat)
          show (Box cats) `shouldEqual` "[😼😼]"
    suite "parses" do
      test "cat" do
        parseEquation "😼" `shouldEqual` Right Cat
      test "cat in box" do
        parseEquation "[😼]" `shouldEqual` Right (Box (singleton Cat))
      test "cat in box and cat in nested box" do
        let nested = Box (singleton Cat)
        parseEquation "[😼[😼]]" `shouldEqual` Right (Box (cons Cat (singleton nested)))
      test "two cats in box" do
        let cats = cons Cat (singleton Cat)
        parseEquation "[😼😼]" `shouldEqual` Right (Box cats)
