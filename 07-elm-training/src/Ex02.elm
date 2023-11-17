module Ex02 exposing (..)


toAges : List Int -> List String
toAges ages =
    ages |> List.map String.fromInt |> List.map (\age -> age ++ " ans")


test =
    toAges [ 30, 21, 14, 52 ] == [ "30 ans", "21 ans", "14 ans", "52 ans" ]
