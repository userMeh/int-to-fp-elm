module Ex03Solved exposing (..)

{-| Jouons avec les listes !
-}

import Tuple exposing (first)


{-| Teste si le premier argument appartient au second
-}
member : a -> List a -> Bool
member element list =
    case list of
        [] ->
            False

        first :: others ->
            if first == element then
                True

            else
                member element others


testsMember =
    { test1 = member 5 [ 5 ] == True
    , test2 = member 6 [] == False
    , test3 = member 5 [ 1, 2, 3 ] == False
    , test4 = member 5 [ 1, 4, 5, 3, 4 ] == True
    , test5 = member 5 [ 0, 3, 2, 1, 5 ] == True
    }


{-| Teste si la liste contient au moins une valeur True.
Utiliser une récursion!
-}
any : List Bool -> Bool
any bools =
    case bools of
        [] ->
            False

        first :: others ->
            if first then
                True

            else
                any others


anyBis : List Bool -> Bool
anyBis bools =
    case bools of
        [] ->
            False

        first :: others ->
            first || any others


testsAny =
    { test1 = any [] == False
    , test2 = any [ True, False ] == True
    , test3 = any [ False, False, False ] == False
    , test4 = any [ False, False, False, True ] == True
    }


{-| Teste si la liste contient au moins une valeur True.
N'utiliser pas de récursion mais vous avez le droit d'utiliser
la fonction member!
-}
anyUsingMember : List Bool -> Bool
anyUsingMember bools =
    member True bools


testsAnyUsingMember =
    { test1 = anyUsingMember [] == False
    , test2 = anyUsingMember [ True, False ] == True
    , test3 = anyUsingMember [ False, False, False ] == False
    , test4 = anyUsingMember [ False, False, False, True ] == True
    }


{-| Teste si tous les éléments de la liste sont `True`
-}
all : List Bool -> Bool
all bools =
    case bools of
        [] ->
            True

        first :: others ->
            first && any others


testsAll =
    { test1 = all [] == True
    , test2 = all [ True, False ] == False
    , test3 = all [ False, False, False ] == False
    , test4 = all [ False, False, False, True ] == False
    , test5 = all [ True, True, True ] == True
    }


{-| Applique la fonction (premier argument) à tous les éléments de la liste
(second argument)
-}
map : (a -> b) -> List a -> List b
map function list =
    case list of
        [] ->
            []

        first :: others ->
            function first :: map function others


testsMap =
    { test1 = map (\x -> x * 2) [ 1, 2, 3 ] == [ 2, 4, 6 ]
    , test2 = map String.length [ "salut", "hi!" ] == [ 5, 3 ]
    }


{-| Teste si le premier argument appartient au second.
N'utiliser pas de récursion.
Utilisez `map` et/ou `any` et/ou `all`
-}
memberUsingMapAndAny : a -> List a -> Bool
memberUsingMapAndAny searchedElement list =
    list
        |> map (\element -> element == searchedElement)
        |> any


testsMemberUsingMapAndAny =
    { test1 = memberUsingMapAndAny 5 [ 5 ] == True
    , test2 = memberUsingMapAndAny 6 [] == False
    , test3 = memberUsingMapAndAny 5 [ 1, 2, 3 ] == False
    , test4 = memberUsingMapAndAny 5 [ 1, 4, 5, 3, 4 ] == True
    , test5 = memberUsingMapAndAny 5 [ 0, 3, 2, 1, 5 ] == True
    }


{-| Teste si la liste est dans l'ordre croissant
-}
isAscending : List Int -> Bool
isAscending ints =
    case ints of
        [] ->
            True

        -- une liste à un élément est forcément bien triée !
        [ _ ] ->
            True

        first :: second :: others ->
            -- Si on trouve deux éléments successifs
            -- qui ne sont pas rangés dans l'ordre, on peut
            -- s'arrêter et renvoyer False
            if first > second then
                False

            else
                isAscending (second :: others)


testsIsAscending =
    { test1 = isAscending [] == True
    , test2 = isAscending [ 1, 2, 3 ] == True
    , test3 = isAscending [ 1, 2, 3, 1 ] == False
    , test4 = isAscending [ 1, 2, 1, 2 ] == False
    }
