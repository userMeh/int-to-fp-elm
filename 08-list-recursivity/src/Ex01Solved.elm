module Ex01Solved exposing (..)


firstElement : List Int -> Maybe Int
firstElement ints =
    case ints of
        [] ->
            Nothing

        first :: _ ->
            Just first


tests =
    { test1 = firstElement [] == Nothing
    , test2 = firstElement [ 1 ] == Just 1
    , test3 = firstElement [ 2, 5 ] == Just 2
    }
