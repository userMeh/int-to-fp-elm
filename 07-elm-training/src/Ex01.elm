module Ex01 exposing (..)

import Html as H


todos =
    -- oui, #pasgéné le prof a copié collé sa todo-list actuelle.
    [ "Finir le cours de programmation fonctionnelle"
    , "Répéter le réquiem allemand de Brahms"
    , "Appeler le jardinier"
    , "Renvoyer le formulaire à la mairie"
    ]
    

main =
    H.ul [] (List.map (\todo -> H.li [] [ H.text todo ]) todos)
