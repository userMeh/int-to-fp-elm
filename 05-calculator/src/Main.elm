module Main exposing (..)

import Browser
import Html as H exposing (Html)
import Html.Attributes as HA
import Html.Events as HE


type alias Model =
    { number1Input : String }


type Msg
    = Number1InputUpdated String


init : Model
init =
    { number1Input = "" }


update : Msg -> Model -> Model
update msg model =
    case msg of
        Number1InputUpdated string ->
            { model | number1Input = string }


view : Model -> Html Msg
view model =
    H.div []
        [ H.div []
            [ H.text "Entrez un nombre:"
            , H.input [ HA.value model.number1Input, HE.onInput Number1InputUpdated ]
                []
            ]
        , H.div []
            [ -- On tente de convertir le texte rentré par l'utilisateur,
              -- il se peut qu'il ait rentré n'importe quoi !
              case String.toInt model.number1Input of
                -- Dans le cas où la conversion a réussi, on a le nombre dans la variable "number"
                Just number ->
                    H.text ("Vous avez entré le nombre " ++ String.fromInt number)

                -- Sinon, on a la valeur "Nothing"
                Nothing ->
                    H.text "Mais ce n'est pas un nombre ça !!"
            ]
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }
