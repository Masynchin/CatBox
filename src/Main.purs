module Main where

import Prelude

import Effect (Effect)
import Flame (QuerySelector(..), Html)
import Flame.Application.NoEffects as FAN
import Flame.Html.Attribute as HA
import Flame.Html.Element as HE

type Model = { input :: String }

init :: Model
init = { input: "" }

data Message = Input String

update :: Model -> Message -> Model
update model =
  case _ of
    Input newInput -> model { input = newInput }

view :: Model -> Html Message
view _ = HE.main "main" [renderInput]

renderInput :: Html Message
renderInput = HE.label_ [ HE.text "Input Equation:"
                        , HE.input [HA.type' "text", HA.onInput Input]
                        ]

main :: Effect Unit
main = FAN.mount_ (QuerySelector "body") app
  where
    app = { init
          , subscribe: []
          , update
          , view
          }
