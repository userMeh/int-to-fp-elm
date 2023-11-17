module Ex01 exposing (..)

import Html as H


todos =
    -- oui, #pasgéné le prof a copié collé sa todo-list actuelle.
    [ "Finir le cours de programmation fonctionnelle"
    , "Répéter le réquiem allemand de Brahms"
    , "Appeler le jardinier"
    , "Renvoyer le formulaire à la mairie"
    ]


viewTodo todo =
    H.li [] [ H.text todo ]


main =
    H.ul [] (List.map viewTodo todos)
