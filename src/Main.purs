module Main where

import Prelude

import CatBox (Equation(..))
import Data.Array (fromFoldable)
import Data.Either (either)
import Effect (Effect)
import Flame (QuerySelector(..), Html)
import Flame.Application.NoEffects as FAN
import Flame.Html.Attribute as HA
import Flame.Html.Element as HE
import Parser (parseEquation)
import Parsing (ParseError)

type Model = { input :: String }

init :: Model
init = { input: "" }

data Message = Input String

update :: Model -> Message -> Model
update model =
  case _ of
    Input newInput -> model { input = newInput }

view :: Model -> Html Message
view model = HE.main "main" [ inputField, renderInput model.input ]

inputField :: Html Message
inputField = HE.label_
  [ HE.text "Input Equation:"
  , HE.input [ HA.type' "text", HA.onInput Input ]
  ]

renderInput :: String -> Html Message
renderInput = parseEquation >>> either renderParseError renderEquation

renderParseError :: ParseError -> Html Message
renderParseError = HE.text <<< show

renderEquation :: Equation -> Html Message
renderEquation = equationElement <<< renderEquation'

renderEquation' :: Equation -> Html Message
renderEquation' Cat = catElement
renderEquation' (Box equations) = boxElement $ fromFoldable $ renderEquation' <$> equations

equationElement = HE.createElement_ "equation"

boxElement = HE.div [ HA.class' "box" ]

catElement :: Html Message
catElement = HE.text "😼"

main :: Effect Unit
main = FAN.mount_ (QuerySelector "body") app
  where
  app =
    { init
    , subscribe: []
    , update
    , view
    }
