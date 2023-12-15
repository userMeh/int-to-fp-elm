module Ex03 exposing (..)


totalLength : List String -> Int
totalLength strings =
    strings |> List.map String.length |> List.sum


test =
    totalLength [ "hey!", "I am", "Hungry!!" ] == 16
