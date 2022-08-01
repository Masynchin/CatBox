module Main where

import Prelude

import CatBox (Equation(..))
import Data.Array (fromFoldable)
import Data.Either (Either(..))
import Effect (Effect)
import Flame (QuerySelector(..), Html)
import Flame.Application.NoEffects as FAN
import Flame.Event (onKeydown, onSelect)
import Flame.Html.Attribute as HA
import Flame.Html.Element as HE
import Parser (equation)
import Parsing (runParser)

type Model = { input :: String
             , select :: Selection
             }

data Selection = Single Int | Many Int Int

init :: Model
init = { input: ""
       , select: Single (-1)
       }

data Message = Select Int Int | Key String

update :: Model -> Message -> Model
update model =
  case _ of
    Select start end -> if start == end
      then model { select = Single start }
      else model { select = Many start end }
    Key key -> case key of
      "c" -> model { input = "😼" }
      "b" -> model { input = "[" <> model.input <> "]" }
      _ -> model

view :: Model -> Html Message
view model = HE.main "main" [renderInput model.input, renderEquation model.input]

renderInput :: String -> Html Message
renderInput input = HE.label_ [ HE.text "Input Equation:"
                              , HE.input [HA.type' "text", HA.value input, onSelect Select, onKeydown Key]
                              ]

renderEquation :: String -> Html Message
renderEquation input =
  case runParser input equation of
    (Left err) -> HE.text (show err)
    (Right eq) -> equationElement $ renderEquation' eq


renderEquation' :: Equation -> Html Message
renderEquation' Cat = catElement
renderEquation' (Box equations) = boxElement $ fromFoldable $ renderEquation' <$> equations

equationElement = HE.createElement_ "equation"

boxElement = HE.div [HA.class' "box"]

catElement :: Html Message
catElement = HE.text "😼"

main :: Effect Unit
main = FAN.mount_ (QuerySelector "body") app
  where
    app = { init
          , subscribe: []
          , update
          , view
          }
