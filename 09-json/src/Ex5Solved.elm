module Ex5Solved exposing (..)

import Json.Decode as JD exposing (Decoder)


{-| Décode une string et s'assure qu'elle est non vide.
-}
nonEmptyStringDecoder : Decoder String
nonEmptyStringDecoder =
    JD.string
        |> JD.andThen
            (\string ->
                if String.isEmpty string then
                    JD.fail "the string has to be empty"

                else
                    JD.succeed string
            )


testNonEmptyStringDecoder =
    { test1 =
        JD.decodeString nonEmptyStringDecoder "\"Hello\""
            == Ok "Hello"
    , test2 =
        JD.decodeString nonEmptyStringDecoder "\"\""
            |> isError
    }



--------------------------------


type alias Person =
    { name : String
    , age : Int
    }


{-| Décode une personne en s'assurant que le nom est non vide
et l'âge est positif
-}
personDecoder : Decoder Person
personDecoder =
    JD.map2 Person
        (JD.field "name" nonEmptyStringDecoder)
        (JD.field "age" ageDecoder)


ageDecoder : Decoder Int
ageDecoder =
    JD.andThen
        (\decodedInt ->
            if decodedInt >= 0 then
                JD.succeed decodedInt

            else
                JD.fail "l'âge doit être positif"
        )
        JD.int


testPersonDecoder =
    { test1 =
        JD.decodeString personDecoder """{ "name": "Alice", "age": 25 }"""
            == Ok
                { name = "Alice"
                , age = 25
                }
    , test2 =
        JD.decodeString personDecoder """{ "name": "", "age": 25 }"""
            |> isError
    , test3 =
        JD.decodeString personDecoder """{ "name": "Bob", "age": -5 }"""
            |> isError
    }


isError : Result err val -> Bool
isError result =
    case result of
        Ok _ ->
            False

        Err _ ->
            True
