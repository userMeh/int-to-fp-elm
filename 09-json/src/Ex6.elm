module Ex6 exposing (..)

import Html exposing (address)
import Json.Decode as JD exposing (Decoder)


type AccountKind
    = Enterprise
    | Individual
    | NonProfit


{-| Le type de compte est encodé en français :

  - entreprise
  - individuel
  - association

-}
accountKindDecoder : Decoder AccountKind
accountKindDecoder =
    Debug.todo "accountKind"


testAccountKindDecoder =
    let
        test json val =
            JD.decodeString accountKindDecoder json
                == Ok val
    in
    { test1 = test "entreprise" Enterprise
    , test2 = test "individuel" Individual
    , test3 = test "association" NonProfit
    }



-----------------------------


type alias Person =
    { name : String
    , address : String
    }


{-| Ce décodeur est donné, vous pouvez l'utiliser
dans la suite
-}
personDecoder : Decoder Person
personDecoder =
    JD.map2
        (\decodedName decodedAddress ->
            { name = decodedName
            , address = decodedAddress
            }
        )
        (JD.field "name" JD.string)
        (JD.field "address" JD.string)


type BillStatus
    = Paid
    | Unpaid


type alias Bill =
    { amount : Int
    , status : BillStatus
    , emitter : Person
    , receiver : Person
    }


jsonBill =
    """{
    "emmitter": { "name": "Arthur Dent", "address": "Earth" },
    "receiver": { "name": "Ford Perfect", "address": "Betelgeuse" },
    "amount": 53113,
    "paid": true
}"""


billDecoder : Decoder Bill
billDecoder =
    Debug.todo "bill"


testBillDecoder =
    JD.decodeString billDecoder jsonBill
        == Ok
            { emitter = { name = "Arthur Dent", address = "Earth" }
            , receiver = { name = "Ford Perfect", address = "Betelgeuse" }
            , status = Paid
            , amount = 53113
            }



---------------------------
-- Pour le dernier exercice, je vous propose de créer vous-même
-- les types idoines et de définir un ou des décodeurs afin
-- de représenter l'extrai json que voici:


jsonShapes =
    """[
    { "kind": "Circle", "radius": 10, "center": {"x": 0, "y": 30 }},
    { "kind": "Rectangle", 
        "topLeft": { "x": 10, "y": 50},
        "bottomRight": { "x": 25, "y": 30 },
    },
    { "kind": "Polygon", "points": [ { "x": 25, "y": 30 }, { "x": 53, "y": 64 }, { "x": -45, "y": 32 } ] }
]"""



--------------------------
-- Bonus !


{-| Réécrire JD.map2 en utilisant uniquement JD.andThen et JD.succeed
(mais sans map2 bien sûr !)
-}
map2 : (a -> b -> c) -> Decoder a -> Decoder b -> Decoder c
map2 f decoderA decoderB =
    Debug.todo "map2"
