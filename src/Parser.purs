module Parser
  ( equation
  ) where

import Prelude

import CatBox (Equation(..))
import Control.Alt ((<|>))
import Parsing (Parser)
import Parsing.Combinators (many1)
import Parsing.String (char, string)

type P a = Parser String a

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
