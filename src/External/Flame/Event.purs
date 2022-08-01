module Flame.Event
  ( onKeydown
  , onSelect
  )
  where

import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Uncurried (EffectFn1, runEffectFn1)
import Flame.Html.Attribute (createRawEvent)
import Flame.Types (NodeData)
import Web.Event.Event (Event, preventDefault)

-- | JS functions to extract selection bounds from event.
foreign import selectionStart_ :: EffectFn1 Event Int
foreign import selectionEnd_ :: EffectFn1 Event Int
foreign import key_ :: EffectFn1 Event String
foreign import keyCode_ :: EffectFn1 Event Int

selectionStart :: Event -> Effect Int
selectionStart = runEffectFn1 selectionStart_

selectionEnd :: Event -> Effect Int
selectionEnd = runEffectFn1 selectionEnd_

key :: Event -> Effect String
key = runEffectFn1 key_

keyCode :: Event -> Effect Int
keyCode = runEffectFn1 keyCode_

-- | "select" event hook.
onSelect :: forall message. (Int -> Int -> message) -> NodeData message
onSelect constructor = createRawEvent "select" (selectHandler constructor)

-- | "select" event handler.
selectHandler :: forall message. (Int -> Int -> message) -> Event -> Effect (Maybe message)
selectHandler constructor event = Just <$> (constructor <$> selectionStart event <*> selectionEnd event)


-- | "keydown" event hook.
onKeydown :: forall message. (String -> message) -> NodeData message
onKeydown constructor = createRawEvent "keydown" (keydownHandler constructor)

-- | "keydown" event handler.
keydownHandler :: forall message. (String -> message) -> Event -> Effect (Maybe message)
keydownHandler constructor event = do
  code <- keyCode event
  case code of
    -- arrow left
    37 -> Just <$> constructor <$> key event
    -- arrow right
    39 -> Just <$> constructor <$> key event
    -- any other
    _ -> do
      preventDefault event
      Just <$> constructor <$> key event
