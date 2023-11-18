module Main5Solved exposing (..)

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
            [ case String.toInt model.number1Input of
                Just number1 ->
                    case String.toInt model.number2Input of
                        Just number2 ->
                            H.text ("La somme des nombres est " ++ String.fromInt (number1 + number2))

                        Nothing ->
                            H.text "Le deuxième champ n'est pas un nombre !!"

                Nothing ->
                    H.text "Le premier champ n'est pas un nombre !!"
            ]
        , -- VARIANTE
          H.div []
            [ case ( String.toInt model.number1Input, String.toInt model.number2Input ) of
                ( Just number1, Just number2 ) ->
                    H.text ("La somme des nombres est " ++ String.fromInt (number1 + number2))

                -- Le caractère _ est une sorte de "joker", toutes les valeurs vont vérifier cette branche
                ( Nothing, _ ) ->
                    H.text "Le premier champ n'est pas un nombre !!"

                ( _, Nothing ) ->
                    H.text "Le deuxième champ n'est pas un nombre !!"
            ]
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }
