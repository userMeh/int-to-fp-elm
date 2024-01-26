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
    JD.string
        |> JD.andThen
            (\str ->
                case String.toLower str of
                    "entreprise" ->
                        JD.succeed Enterprise

                    "individuel" ->
                        JD.succeed Individual

                    "association" ->
                        JD.succeed NonProfit

                    _ ->
                        JD.fail "Unknown"
            )


testAccountKindDecoder =
    let
        test json val =
            JD.decodeString accountKindDecoder json
                == Ok val
    in
    { test1 = test "\"entreprise\"" Enterprise
    , test2 = test "\"individuel\"" Individual
    , test3 = test "\"association\"" NonProfit
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
    JD.map4
        (\amount status emitter receiver ->
            { amount = amount
            , status = status
            , emitter = emitter
            , receiver = receiver
            }
        )
        (JD.field "amount" JD.int)
        (JD.field "paid" (JD.map (\b -> if b then Paid else Unpaid) JD.bool))
        (JD.field "emmitter" personDecoder)
        (JD.field "receiver" personDecoder)


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

type alias Point =
    {
        x : Int, 
        y : Int
    }

type Shape
    = Circle Int Point
    | Rectangle Point Point
    | Polygon (List Point)

pointDecoder : Decoder Point
pointDecoder =
    JD.map2
        (\x y ->
            { x = x
            , y = y
            }
        )
        (JD.field "x" JD.int)
        (JD.field "y" JD.int)

shapeDecoder : Decoder Shape
shapeDecoder =
    JD.field "kind" JD.string
        |> JD.andThen
            (\kind ->
                case kind of
                    "Circle" -> 
                        JD.map2
                            (\radius center ->
                                Circle radius center
                            )
                            (JD.field "radius" JD.int)
                            (JD.field "center" pointDecoder)

                    "Rectangle" ->
                        JD.map2
                            (\topLeft bottomRight ->
                                Rectangle topLeft bottomRight
                            )
                            (JD.field "topLeft" pointDecoder)
                            (JD.field "bottomRight" pointDecoder)

                    "Polygon" ->
                        JD.map
                            (\points ->
                                Polygon points
                            )
                            (JD.field "points" (JD.list pointDecoder))

                    _ ->
                        JD.fail "Unknown"
            )

testShapeDecoder =
    JD.decodeString (JD.list shapeDecoder) jsonShapes
        == Ok
            { 
                kind = "Circle", 
                radius = 10, 
                center = { x = 0, y = 30 } 
            }


--------------------------
-- Bonus !


{-| Réécrire JD.map2 en utilisant uniquement JD.andThen et JD.succeed
(mais sans map2 bien sûr !)
-}
map2 : (a -> b -> c) -> Decoder a -> Decoder b -> Decoder c
map2 f decoderA decoderB =
    JD.andThen
        (\a ->
            JD.andThen
                (\b ->
                    JD.succeed (f a b)
                )
                decoderB
        )
        decoderA
