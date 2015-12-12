import Html exposing (..)
import Effects
import StartApp

type alias AppState =
    { number: Int
    }

type Action
    = NoOp

init : (AppState, Effects.Effects Action)
init =
    ({number = 0}, Effects.none)

update : Action -> AppState -> (AppState, Effects.Effects a)
update action state =
    case action of
        NoOp ->
            (state, Effects.none)

view : Signal.Address Action -> AppState -> Html
view address state =
    p [] [text (toString state)]

app : StartApp.App AppState
app = StartApp.start
        { init = init
        , update = update
        , view = view
        , inputs = []
        }

main : Signal Html
main = app.html