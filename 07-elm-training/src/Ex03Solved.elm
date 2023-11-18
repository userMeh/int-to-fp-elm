module Ex03Solved exposing (..)


totalLength : List String -> Int
totalLength strings =
    strings
        |> List.map String.length
        |> List.sum


test =
    totalLength [ "hey!", "I am", "Hungry!!" ] == 16
