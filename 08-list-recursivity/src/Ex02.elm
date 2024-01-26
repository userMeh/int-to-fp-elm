module Ex02 exposing (..)


toKeyValue : String -> Maybe { key : String, value : String }
toKeyValue string =
    Nothing


tests =
    { test1 = toKeyValue "" == Nothing
    , test2 = toKeyValue "bla" == Nothing
    , test3 = toKeyValue "bla:bli" == Just { key = "bla", value = "bli" }
    , test4 = toKeyValue "bla:bli:blo" == Just { key = "bla", value = "bli:blo" }
    }
