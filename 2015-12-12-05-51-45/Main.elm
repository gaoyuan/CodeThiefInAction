module Main where

import Keyboard
import Foo
import Bar

type Action =
  FooEvent Foo.Action
  | BarEvent Bar.Action
  
type alias Model =
  { fooModel : Foo.Model
  , barModel : Bar.Model
  }

main : Signal Html
main =
  app.html

app : StartApp.App Model
app =
  StartApp.start { init = init
  , update = update
  , view = view
  , inputs = inputs
  }

inputs : List (Signal Action)
inputs =
  [ Signal.map (FooEvent Foo.MetaKeyDown) Keyboard.meta -- this is clearly wrong as Foo.MetaKeyDown is not a reference I can make
  ]
