module Ex2 exposing (..)

import Json.Decode as JD exposing (Decoder)



--------------------------------


jsonPerson =
    """{
    "name": "Sébastien",
    "age": 42
}"""


{-| Décode le nom de la personne représentée ci-dessus. Vous
aurea probablement besoin d'utiliser ce décodeur:
<https://package.elm-lang.org/packages/elm/json/latest/Json-Decode#string>
-}
nameDecoder : Decoder String
nameDecoder =
    JD.field "name" JD.string 


testNameDecoder =
    JD.decodeString nameDecoder jsonPerson == Ok "Sébastien"



--------------------------------


jsonOrder =
    """{
  "person": { "name": "Seb", "age": 42 },
  "product": { "name": "Table", "price": 58 }
}"""


{-| Décode le pix de la commande précédente
-}
deepPriceDecoder : Decoder Int
deepPriceDecoder =
    JD.field "product" (JD.field "price" JD.int)


testDeepPriceDecoder =
    JD.decodeString deepPriceDecoder jsonOrder == Ok 58



-- BONUS: trouver une fonction dans le module `Json.Decode`
-- permettant de récupérer ce prix de façon plus simple.
--------------------------------


jsonArrayOfInts =
    "[45, 32, 24]"


{-| Décode la liste d'entier donnée ci-dessus. Vous aurez
probablement besoin d'utiliser ce combinateur
<https://package.elm-lang.org/packages/elm/json/latest/Json-Decode#list>
-}
listOfIntsDecoder : Decoder (List Int)
listOfIntsDecoder =
    JD.list JD.int


testListOfIntsDecoder =
    let
        test str =
            JD.decodeString listOfIntsDecoder str
    in
    { test1 = test jsonArrayOfInts == Ok [ 45, 32, 24 ]
    , test2 = test "[]" == Ok []
    }



--------------------------------


jsonArrayOfArraysOfInts =
    "[[1, 2, 3], [42, 6, 9], [5,1]]"


listOfListsOfIntsDecoder : Decoder (List (List Int))
listOfListsOfIntsDecoder =
    JD.list (JD.list JD.int)


testListOfListsOfIntsDecoder =
    let
        test str =
            JD.decodeString listOfListsOfIntsDecoder str
    in
    { test1 = test jsonArrayOfArraysOfInts == Ok [ [ 1, 2, 3 ], [ 42, 6, 9 ], [ 5, 1 ] ]
    , test2 = test "[[]]" == Ok [ [] ]
    }
