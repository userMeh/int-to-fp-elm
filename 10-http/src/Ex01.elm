module Ex01 exposing (..)

import Browser
import Html as H exposing (Html)
import Html.Attributes as HA
import Html.Events as HE
import Http



-- Jusqu'à maintenant, nos programmes étaient plutôt simples et ne dépendaient pas du monde extérieur.
--
-- En Elm, on considère que le monde extérieur est "dangereux" : que se passe-t-il quand un appel réseau
-- échoue ? Ou retourne un format inattendu ?
--
-- On délègue donc cette tâche au _runtime_ qui va nous protéger et nous forcer à gérer ces cas d'erreur
-- (en Elm, les gestes barrières, c'est tout le temps 😷 ).
--
-- Ainsi, pour effectuer un appel HTTP, on passe par le concept de "commande": notre fonction d'update
-- renvoie maintenant le nouveau modèle ET une commande à exécuter (dans notre cas, une requête HTTP).
--
-- Le runtime effectue l'appel, puis nous retourne le résultat dans un message (dans notre cas `QuoteFetched`).


type alias Model =
    { quote : String }


initialModel : Model
initialModel =
    { quote = "Cliquez sur un bouton pour charger une citation 😉" }


type Msg
    = QuoteButtonClicked String
      -- L'appel HTTP peut échouer, c'est pourquoi on reçoit un `Result` qui contient soit une erreur, soit une citation
    | QuoteFetched (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        QuoteButtonClicked url ->
            ( { model | quote = "Chargement..." }, Http.get { expect = Http.expectString QuoteFetched } )

        QuoteFetched result ->
            case result of
                Err error ->
                    ( { model | quote = "Erreur! 😱" }, Cmd.none )


view : Model -> Html Msg
view model =
    H.div []
        [ H.div []
            [ H.button [ HE.onClick (QuoteButtonClicked "/resources/quote-1.txt"), HA.style "margin-right" "1em" ] [ H.text "Récupérer la citation 1" ]
            , H.button [ HE.onClick (QuoteButtonClicked "/resources/quote-2.txt"), HA.style "margin-right" "1em" ] [ H.text "Récupérer la citation 2" ]
            , H.button [ HE.onClick (QuoteButtonClicked "/resources/quote-3.txt") ] [ H.text "Récupérer la citation 3" ]
            ]
        , H.pre
            [ HA.style "padding" "10px"
            , HA.style "border" "1px solid gray"
            , HA.style "max-width" "500px"
            , HA.style "white-space" "pre-wrap"
            , HA.style "margin" "10px"
            ]
            [ H.text model.quote ]
        ]


main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> ( initialModel, Cmd.none )
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
