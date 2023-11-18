module Ex02Solved exposing (..)


toKeyValue : String -> Maybe { key : String, value : String }
toKeyValue string =
    case String.split ":" string of
        [] ->
            -- Ce cas ne devrait pas se produire, String.split
            -- renvoie au moins une liste à un élément
            Nothing

        [ _ ] ->
            -- S'il n'y qu'un seul élément dans la liste,
            -- c'est qu'il n'y a pas de ":" dans la string
            Nothing

        first :: others ->
            Just
                { key = first

                -- s'il y avait plusieurs ":" dans la string initiale
                -- `others` comprendrait plusieurs strings qu'il faut
                -- "recoller" avec ":"
                , value = String.join ":" others
                }


tests =
    { test1 = toKeyValue "" == Nothing
    , test2 = toKeyValue "bla" == Nothing
    , test3 = toKeyValue "bla:bli" == Just { key = "bla", value = "bli" }
    , test4 = toKeyValue "bla:bli:blo" == Just { key = "bla", value = "bli:blo" }
    }
