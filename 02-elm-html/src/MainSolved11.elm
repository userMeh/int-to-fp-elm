module MainSolved11 exposing (..)

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
    [ { description = "En 2023, la température de la terre a augmenté de 1.2°C par rapport à l'ère pré-industrielle"
      , imageUrl = "https://www.funny-emoticons.com/files/smileys-emoticons/funny-emoticons/51-too-hot.png"
      , source = "https://www.geo.fr/environnement/climat-la-temperature-a-lechelle-mondiale-a-augmente-de-12c-depuis-lepoque-preindustrielle-207876"
      }
    , { description = "La hausse des températures induit une perturbation du cycle de l'eau : plus de sécheresses, mais aussi plus de pluies torrentielles"
      , imageUrl = "https://www.freepnglogos.com/uploads/water-drop-png/water-drop-falling-illustration-transparent-png-svg-vector-29.png"
      , source = "https://www.huffingtonpost.fr/science/article/le-cycle-de-l-eau-est-en-train-de-changer-et-c-est-inquietant_195642.html#:~:text=%C3%80%20cause%20du%20r%C3%A9chauffement%20climatique,s%C3%A9cheresses%20et%20autres%20catastrophes%20naturelles.&text=jorgeciscar%20%2F%20500px%20via%20Getty%20Images,%C3%A0%20cause%20du%20r%C3%A9chauffement%20climatique."
      }
    , { description = "Un aller-retour en avion Paris New York émet 1.9 tonne de CO2"
      , imageUrl = "https://www.pngall.com/wp-content/uploads/2016/05/Plane-Download-PNG.png"
      , source = "https://co2.myclimate.org/fr/portfolios?calculation_id=6191028"
      }
    , { description = "Il y 20 000 ans, la température était 5°C en-dessous de celle de l'ère pré-industrielle et les mers étaient 120m plus hautes."
      , imageUrl = "https://caristeo.com/wp-content/uploads/2022/07/Europe-20-000-ans-jpeg.jpg"
      , source = "https://www.youtube.com/watch?v=I3CsL15U-sM&t=1644s&ab_channel=Jean-MarcJancovici"
      }
    , { description = "Pour respecter les accords de Paris et rester sous les 2°C de réchauffement, il faut que chaque personne émette 2 tonnes d'équivalent CO2 par an."
      , imageUrl = "https://www.liberateurdidees.com/web/image/product.template/4091/image_1024?unique=74a90e4"
      , source = "https://www.2tonnes.org/#:~:text=Pourquoi%202%20tonnes%20%3F&text=Afin%20de%20limiter%20les,ici%20la%20fin%20du%20si%C3%A8cle."
      }
    , { description = "On peut baisser nos émissions significativement en mangeant moins de viande"
      , imageUrl = "https://is3-ssl.mzstatic.com/image/thumb/Purple126/v4/ef/63/1d/ef631dfd-5741-0070-18a5-3f1ac1852041/source/256x256bb.jpg"
      , source = "https://www.trajectoires.media/f/impact-viande-climat"
      }
    ]


viewCard : { description : String, imageUrl : String, source : String } -> Html msg
viewCard fact =
    H.li [ HA.class "w-96 p-3 rounded shadow border-l-4 border-solid border-blue-500 flex items-start space-x-4" ]
        [ H.div [ HA.class "w-12 h-12 flex-shrink-0 rounded-full overflow-hidden shadow-lg" ]
            [ H.img [ HA.src fact.imageUrl, HA.class "w-full h-full object-cover" ] []
            ]
        , H.div []
            [ H.p [ HA.class "font-bold" ] [ H.text fact.description ]
            , H.a
                [ HA.href fact.source
                , HA.class "text-blue-500 text-sm underline"
                , HA.target "_blank"
                ]
                [ H.text "source" ]
            ]
        ]


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
