module Main where

import Prelude

import CatBox (Equation(..))
import Data.Array (fromFoldable)
import Data.Either (Either(..))
import Effect (Effect)
import Flame (QuerySelector(..), Html)
import Flame.Application.NoEffects as FAN
import Flame.Html.Attribute as HA
import Flame.Html.Element as HE
import Parser (equation)
import Parsing (runParser)

type Model = { input :: String }

init :: Model
init = { input: "" }

data Message = Input String

update :: Model -> Message -> Model
update model =
  case _ of
    Input newInput -> model { input = newInput }

view :: Model -> Html Message
view model = HE.main "main" [renderInput, renderEquation model.input]

renderInput :: Html Message
renderInput = HE.label_ [ HE.text "Input Equation:"
                        , HE.input [HA.type' "text", HA.onInput Input]
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
