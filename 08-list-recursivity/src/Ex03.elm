module Ex03 exposing (..)

{-| Jouons avec les listes !
-}


{-| Teste si le premier argument appartient au second
-}
member : a -> List a -> Bool
member element list =
    Debug.todo "member"


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
    Debug.todo "any"


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
    Debug.todo "any using member"


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
    Debug.todo "all"


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
    Debug.todo "map"


testsMap =
    { test1 = map (\x -> x * 2) [ 1, 2, 3 ] == [ 2, 4, 6 ]
    , test2 = map String.length [ "salut", "hi!" ] == [ 5, 3 ]
    }


{-| Teste si le premier argument appartient au second.
N'utiliser pas de récursion.
Utilisez `map` et/ou `any` et/ou `all`
-}
memberUsingMapAndAny : a -> List a -> Bool
memberUsingMapAndAny element list =
    Debug.todo "memberUsingMapAndAny"


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
    Debug.todo "isAscending"


testsIsAscending =
    { test1 = isAscending [] == True
    , test2 = isAscending [ 1, 2, 3 ] == True
    , test3 = isAscending [ 1, 2, 3, 1 ] == False
    , test4 = isAscending [ 1, 2, 1, 2 ] == False
    }
