module Ex3 exposing (..)

import Json.Decode as JD exposing (Decoder)



--------------------------------


jsonPerson =
    """{
    "name": "Seb",
    "age": 42
}"""


{-| récupère l'âge dans le json précédent et l'encapsule dans un
record.
-}
ageDecoder : Decoder { age : Int }
ageDecoder =
    Debug.todo "ageDecoder"


testNameDecoder =
    JD.decodeString ageDecoder jsonPerson == Ok { age = 42 }
