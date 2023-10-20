module Main exposing (..)

import Html as H exposing (Html)
import Html.Attributes as HA


homeScreen =
    H.div [ HA.class "h-screen flex" ]
        [ H.div
            [ HA.class "w-1/4 h-screen bg-gray-200" ]
            [ H.div
                [ HA.class "p-4" ]
                [ H.span
                    [ HA.class "text-lg font-bold" ]
                    [ H.text "Menu" ]
                , H.p [] [ H.text "Item 1" ]
                , H.p [] [ H.text "Item 2" ]
                , H.p [] [ H.text "Item 3" ]
                ]
            ]
        , H.div
            [ HA.class "w-3/4" ]
            [ H.div
                [ HA.class "bg-blue-500 p-4" ]
                [ H.span
                    [ HA.class "text-3xl text-white" ]
                    [ H.text "Site Title" ]
                ]
            , H.div [ HA.class "p-4" ]
                [ H.p
                    []
                    [ H.text "Welcome to the site's content." ]
                , H.p
                    []
                    [ H.text "This is where your content goes." ]
                ]
            ]
        ]


aboutMeScreen =
    H.text "C'est moi !"


main =
    H.div []
        [ -- The link tag should be in the header, but we don't have access to the header in the simple usage
          -- we have of elm (it is of course possible but asks for more envolved setup).
          H.node "link"
            [ HA.attribute "href" "https://cdn.jsdelivr.net/npm/tailwindcss@2.2.15/dist/tailwind.min.css"
            , HA.attribute "rel" "stylesheet"
            ]
            []
        , homeScreen
        , separatorScreen
        , aboutMeScreen
        ]


separatorScreen =
    H.div [ HA.class "bg-red-500 h-10" ] []
