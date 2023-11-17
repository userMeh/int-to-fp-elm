module Main7Solved exposing (..)

import Browser
import Html as H exposing (Html)
import Html.Attributes as HA
import Html.Events as HE


type alias Model =
    { number1Input : String
    , number2Input : String
    }


type Msg
    = Number1InputUpdated String
    | Number2InputUpdated String


init : Model
init =
    { number1Input = ""
    , number2Input = ""
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        Number1InputUpdated string ->
            { model | number1Input = string }

        Number2InputUpdated string ->
            { model | number2Input = string }


parseInput : Model -> Maybe { number1 : Int, number2 : Int }
parseInput model =
    case String.toInt model.number1Input of
        Just number1 ->
            case String.toInt model.number2Input of
                Just number2 ->
                    Just { number1 = number1, number2 = number2 }

                Nothing ->
                    Nothing

        Nothing ->
            Nothing


view : Model -> Html Msg
view model =
    H.div []
        [ H.div []
            [ H.text "Entrez un nombre:"
            , H.input [ HA.value model.number1Input, HE.onInput Number1InputUpdated ]
                []
            ]
        , H.div []
            [ H.text "Entrez un nombre:"
            , H.input [ HA.value model.number2Input, HE.onInput Number2InputUpdated ]
                []
            ]
        , H.div []
            [ case parseInput model of
                Just numbers ->
                    H.text ("La somme des nombres est " ++ String.fromInt (numbers.number1 + numbers.number2))

                Nothing ->
                    H.text "Rentrer des nombres !!"
            ]
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }
