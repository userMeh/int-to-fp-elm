module Ex4 exposing (..)

import Json.Decode as JD exposing (Decoder)


jsonPlayer : String
jsonPlayer =
    """{ 
  "name": "Ford",
  "score": 42,
  "favorite_color": "red",
  "from": "Betelgeuse"
}"""


type alias Player =
    { name : String
    , score : Int
    , origin : String
    }


playerDecoder : Decoder Player
playerDecoder =
    Debug.todo "player"


testPlayerDecoder =
    JD.decodeString playerDecoder jsonPlayer
        == Ok
            { name = "Ford"
            , score = 42
            , origin = "Betelgeuse"
            }



-------------------------------------------------


jsonBoard : String
jsonBoard =
    """{
  "players": [{ 
    "name": "Ford",
    "score": 42,
    "favorite_color": "red",
    "from": "Betelgeuse"
  }],
  "games": ["pong", "tetris"]
}"""


type alias Board =
    { players : List Player
    , games : List String
    }


boardDecoder : Decoder Board
boardDecoder =
    Debug.todo "board"


testBoardDecoder =
    JD.decodeString boardDecoder jsonPlayer
        == Ok
            { players =
                [ { name = "Ford"
                  , score = 42
                  , origin = "Betelgeuse"
                  }
                ]
            , games = [ "pong", "tetris" ]
            }
