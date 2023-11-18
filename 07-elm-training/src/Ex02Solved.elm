module Ex02Solved exposing (..)


toAges : List Int -> List String
toAges ages =
    List.map (\age -> String.fromInt age ++ " ans") ages


test =
    toAges [ 30, 21, 14, 52 ] == [ "30 ans", "21 ans", "14 ans", "52 ans" ]
