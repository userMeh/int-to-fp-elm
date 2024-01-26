module MainSolved exposing (main)

import Browser
import Html as H exposing (Html)
import Html.Events as HE


type alias Model =
    { count : Int }


type Msg
    = IncrementClicked
    | DecrementClicked
    | ResetClicked


init : Model
init =
    { count = 0 }


update : Msg -> Model -> Model
update msg model =
    case msg of
        IncrementClicked ->
            { model | count = model.count + 1 }

        DecrementClicked ->
            { model | count = model.count - 1 }

        ResetClicked ->
            { model | count = 0 }


view : Model -> Html Msg
view model =
    H.div []
        [ H.div [] [ H.button [ HE.onClick IncrementClicked ] [ H.text "+" ] ]
        , H.div [] [ H.text (String.fromInt model.count) ]
        , H.div [] [ H.button [ HE.onClick DecrementClicked ] [ H.text "-" ] ]
        , H.div [] [ H.button [ HE.onClick ResetClicked ] [ H.text "Reset" ] ]
        ]


main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }
