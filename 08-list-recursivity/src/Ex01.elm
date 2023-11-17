module Ex01 exposing (..)


firstElement : List Int -> Maybe Int
firstElement ints =
    Nothing


tests =
    { test1 = firstElement [] == Nothing
    , test2 = firstElement [ 1 ] == Just 1
    , test3 = firstElement [ 2, 5 ] == Just 2
    }
