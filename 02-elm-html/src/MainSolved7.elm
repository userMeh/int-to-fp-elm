module MainSolved7 exposing (..)

import Html as H exposing (Html)
import Html.Attributes as HA


layout content =
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
            , H.div [ HA.class "p-4" ] content
            ]
        ]


homeScreen =
    layout
        [ H.p
            []
            [ H.text "Welcome to the site's content." ]
        , H.p
            []
            [ H.text "This is where your content goes." ]
        ]


aboutMeScren =
    layout
        [ H.p
            []
            [ H.text "Je m'appelle Seb." ]
        , H.p
            []
            [ H.text "J'aime la tartiflette" ]
        ]


facts =
    [ "En 2023, la température de la terre a augmenté de 1.2°C par rapport à l'ère pré-industrielle"
    , "La hausse des températures induit une perturbation du cycle de l'eau : plus de sécheresses, mais aussi plus de pluies torrentielles"
    , "Un aller-retour en avion Paris New York émet 1.75 tonne de CO2"
    , "Il y 20 000 ans, la température était 5°C en-dessous de celle de l'ère pré-industrielle et les mers étaient 120m plus hautes."
    , "Pour respecter les accords de Paris et rester sous les 2°C de réchauffement, il faut que chaque personne émette 2 tonnes d'équivalent CO2 par an."
    ]


viewCard text =
    H.li
        [ HA.class "p-3 rounded shadow border-l-4 border-solid border-blue-500" ]
        [ H.text text ]


thingsToKnowScreen =
    layout
        [ H.ul [ HA.class "flex flex-col space-y-8" ]
            (List.map viewCard facts)
        ]


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
        , screenSeparator
        , aboutMeScren
        , screenSeparator
        , thingsToKnowScreen
        ]


screenSeparator =
    H.div [ HA.class "bg-red-500 h-10" ] []
