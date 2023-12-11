module Ex1 exposing (..)

import Dict exposing (Dict)
import Json.Decode as JD
import Json.Encode as JE exposing (Value)
import List exposing (product)


encodeAge : Int -> Value
encodeAge age =
    Debug.todo "age"


testAge =
    let
        test age =
            JD.decodeValue JD.int (encodeAge age) == Ok age
    in
    { test1 = test 42
    , test2 = test -54
    }



--------------------------------


encodeName : String -> Value
encodeName name =
    Debug.todo "name"


testName =
    let
        test name =
            JD.decodeValue JD.string (encodeName name) == Ok name
    in
    { test1 = test "Seb"
    , test2 = test "Charlie"
    }



--------------------------------


encodeListOfInts : List Int -> Value
encodeListOfInts ints =
    Debug.todo "listOfInts"


testListOfInts =
    let
        test ints =
            JD.decodeValue (JD.list JD.int) (encodeListOfInts ints) == Ok ints
    in
    { test1 = test [ 1, 2, 3 ]
    , test2 = test [ 42, -95, 15, 10 ]
    }



--------------------------------


type alias Person =
    { name : String
    , age : Int
    }


encodePerson : Person -> Value
encodePerson person =
    Debug.todo "person"


testPerson =
    let
        test person =
            JD.decodeValue (JD.map2 Person (JD.field "name" JD.string) (JD.field "age" JD.int)) (encodePerson person) == Ok person
    in
    { test1 = test { name = "Seb", age = 42 }
    , test2 = test { name = "Charlie", age = 54 }
    }



--------------------------------


{-| The Person type stays the same, but the json representation should
look something like:
{ "fullName": "Seb", "years": 42 }

Note you can totally decouple the json representation
of an object from its Elm's type!

-}
encodePerson2 : Person -> Value
encodePerson2 person =
    Debug.todo "person2"


testPerson2 =
    let
        test person =
            JD.decodeValue
                (JD.map2 Person (JD.field "fullName" JD.string) (JD.field "years" JD.int))
                (encodePerson2 person)
                == Ok person
    in
    { test1 = test { name = "Seb", age = 42 }
    , test2 = test { name = "Charlie", age = 54 }
    }



--------------------------------


type alias Product =
    { name : String
    , price : Int
    }


encodeProduct : Product -> Value
encodeProduct product =
    Debug.todo "product"


testProduct =
    let
        test product =
            JD.decodeValue
                (JD.map2 Product (JD.field "name" JD.string) (JD.field "price" JD.int))
                (encodeProduct product)
                == Ok product
    in
    { test1 = test { name = "Table", price = 53 }
    , test2 = test { name = "Chaise", price = 12 }
    }



--------------------------------


type alias Order =
    { person : Person
    , product : Product
    , quantity : Int
    }


{-| You should re-use the `encodeProduct` and `encodePerson` functions!
-}
encodeOrder : Order -> Value
encodeOrder order =
    Debug.todo "order"


testOrder =
    let
        test order =
            JD.decodeValue
                (JD.map3 Order
                    (JD.field "person" (JD.map2 Person (JD.field "name" JD.string) (JD.field "age" JD.int)))
                    (JD.field "product" (JD.map2 Product (JD.field "name" JD.string) (JD.field "price" JD.int)))
                    (JD.field "quantity" JD.int)
                )
                (encodeOrder order)
                == Ok order
    in
    { test1 =
        test
            { person = { name = "Seb", age = 42 }
            , product = { name = "Table", price = 53 }
            , quantity = 2
            }
    , test2 =
        test
            { person = { name = "Seb", age = 42 }
            , product = { name = "Table", price = 53 }
            , quantity = 5
            }
    }



--------------------------------


type alias FriendlyPerson =
    { name : String
    , age : Int
    , friends : List Person
    }


{-| Hint: you can re-use the `encodePerson` function.
-}
encodeFriendlyPerson : FriendlyPerson -> Value
encodeFriendlyPerson friendlyPerson =
    Debug.todo "friendlyPerson"


testFriendlyPerson =
    let
        test person =
            JD.decodeValue
                (JD.map3 FriendlyPerson
                    (JD.field "name" JD.string)
                    (JD.field "age" JD.int)
                    (JD.field "friends" (JD.list (JD.map2 Person (JD.field "name" JD.string) (JD.field "age" JD.int))))
                )
                (encodeFriendlyPerson person)
                == Ok person
    in
    { test1 = test { name = "Seb", age = 42, friends = [ { name = "Hector", age = 45 }, { name = "Gandhalf", age = 1503 } ] }
    , test2 = test { name = "Charlie", age = 54, friends = [] }
    }



--------------------------------


type Shape
    = Point
    | Square { side : Float }
    | Rect { width : Float, length : Float }


{-| The json will use a "discriminant field" called "kind".
Here are some examples of encoded values:

{ "kind": "Point" }

{ "kind": "Square", "side": 5 }

{ "kind": "Rect", "width": 10, "length": 32 }

-}
encodeShape : Shape -> Value
encodeShape shape =
    Debug.todo "shape"


testShape =
    let
        shapeDecoder =
            JD.field "kind" JD.string
                |> JD.andThen
                    (\kind ->
                        case kind of
                            "Point" ->
                                JD.succeed Point

                            "Square" ->
                                JD.field "side" JD.float
                                    |> JD.map (\side -> Square { side = side })

                            "Rect" ->
                                JD.map2 (\width length -> Rect { width = width, length = length })
                                    (JD.field "width" JD.float)
                                    (JD.field "length" JD.float)

                            _ ->
                                JD.fail ("unknown kind: " ++ kind)
                    )

        test shape =
            JD.decodeValue shapeDecoder (encodeShape shape) == Ok shape
    in
    { test1 = test Point
    , test2 = test (Square { side = 10 })
    , test3 = test (Rect { width = 20, length = 30 })
    }



--------------------------------


{-| Encode a dictionary associating an id to a person in a
JSON object.

    Example: the following elm dictionnary:

    Dict.fromList
        [ ("abc", { name = "Seb", age = 42 })
        , ("def", { name = "John", age = 24 })
        ]

    Will be transformed into the following JSON:
    { "people":
        {
            "abc": { "name": "Seb", "age": 42 },
            "def": { "name": "John", "age": 24 }
        }
    }

    Note: we don't just want the dictionnary in json, we want this
    extra "people" stage.

-}
encodePeopleTable : Dict String Person -> Value
encodePeopleTable peoplyById =
    Debug.todo "peopleTable"


testPeopleTable =
    let
        test people =
            JD.decodeValue
                (JD.field "people"
                    (JD.dict
                        (JD.map2 Person
                            (JD.field "name" JD.string)
                            (JD.field "age" JD.int)
                        )
                    )
                )
                (encodePeopleTable people)
                == Ok people
    in
    { test1 =
        test
            (Dict.fromList
                [ ( "abc", { name = "Seb", age = 42 } )
                , ( "def", { name = "John", age = 24 } )
                ]
            )
    , test2 = test Dict.empty
    }
