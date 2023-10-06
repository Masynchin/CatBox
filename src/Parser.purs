module Parser
  ( equation
  , parseEquation
  ) where

import Prelude

import CatBox (Equation(..))
import Control.Alt ((<|>))
import Data.Either (Either)
import Parsing (ParseError, Parser, runParser)
import Parsing.Combinators (many1)
import Parsing.String (char, string)

type P a = Parser String a

parseEquation :: String -> Either ParseError Equation
parseEquation = flip runParser equation

cat :: P Equation
cat = string "😼" $> Cat

box :: P Equation
box = do
  _ <- char '['
  equations <- many1 (box <|> cat)
  _ <- char ']'
  pure (Box equations)

equation :: P Equation
equation = box <|> cat
