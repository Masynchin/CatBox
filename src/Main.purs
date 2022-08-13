module Main where

import Prelude

import CatBox (Equation(..))
import Data.Array (fromFoldable)
import Data.Either (Either(..))
import Data.String.CodeUnits (splitAt)
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
      "c" -> model { input = putCat model.select model.input }
      "b" -> model { input = "[" <> model.input <> "]" }
      _ -> model

putCat :: Selection -> String -> String
putCat (Many _ _) = identity
putCat (Single n) = put <<< splitAt n
  where put { before, after } = before <> "😼" <> after

view :: Model -> Html Message
view model =
  HE.main "main" [ controlTip
                 , renderInput model.input
                 , renderEquation model.input
                 ]

controlTip :: Html Message
controlTip =
  HE.p_ [ HE.text "Type "
        , kbd [ HE.text "C" ]
        , HE.text " to spawn cat and "
        , kbd [ HE.text "B" ]
        , HE.text " to put cat in the box."
        ]

renderInput :: String -> Html Message
renderInput input =
  HE.label_ [ HE.text "Input Equation:"
            , HE.input [HA.type' "text", HA.value input, HA.autofocus true, onSelect Select, onKeydown Key]
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

kbd = HE.createElement_ "kbd"

main :: Effect Unit
main = FAN.mount_ (QuerySelector "body") app
  where
    app = { init
          , subscribe: []
          , update
          , view
          }
