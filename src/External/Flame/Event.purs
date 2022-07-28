module Flame.Event
  ( onSelect
  )
  where

import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Uncurried (EffectFn1, runEffectFn1)
import Flame.Html.Attribute (createRawEvent)
import Flame.Types (NodeData)
import Web.Event.Event (Event)

-- | JS functions to extract selection bounds from event.
foreign import selectionStart_ :: EffectFn1 Event Int
foreign import selectionEnd_ :: EffectFn1 Event Int

selectionStart :: Event -> Effect Int
selectionStart = runEffectFn1 selectionStart_

selectionEnd :: Event -> Effect Int
selectionEnd = runEffectFn1 selectionEnd_

-- | "select" event hook.
onSelect :: forall message. (Int -> Int -> message) -> NodeData message
onSelect constructor = createRawEvent "select" (selectHandler constructor)

-- | "select" event handler.
selectHandler :: forall message. (Int -> Int -> message) -> Event -> Effect (Maybe message)
selectHandler constructor event = Just <$> (constructor <$> selectionStart event <*> selectionEnd event)
