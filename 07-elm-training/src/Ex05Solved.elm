module Ex05%20copy exposing (..)module Ex05 exposing (..)

import Set


type alias Cart =
    { optionId : String
    , orders : List String
    }


theCarts : List Cart
theCarts =
    [ { optionId = "abc", orders = [ "123-123", "542-64", "789-987", "123-123", "542-64" ] }
    , { optionId = "def", orders = [ "542-64", "789-987", "234-567", "542-64", "123-123" ] }
    , { optionId = "ghi", orders = [ "789-987", "234-567", "890-123", "789-987", "542-64" ] }
    , { optionId = "jkl", orders = [ "234-567", "890-123", "345-678", "234-567", "789-987" ] }
    , { optionId = "mno", orders = [ "890-123", "345-678", "456-789", "890-123", "234-567" ] }
    , { optionId = "pqr", orders = [ "345-678", "456-789", "567-890", "345-678", "890-123" ] }
    , { optionId = "stu", orders = [ "456-789", "567-890", "678-901", "456-789", "345-678" ] }
    , { optionId = "vwx", orders = [ "567-890", "678-901", "789-012", "567-890", "456-789" ] }
    , { optionId = "yz", orders = [ "678-901", "789-012", "890-123", "678-901", "567-890" ] }
    , { optionId = "123", orders = [ "789-012", "890-123", "901-234", "789-012", "678-901" ] }
    , { optionId = "456", orders = [ "890-123", "901-234", "234-567", "890-123", "678-901" ] }
    , { optionId = "789", orders = [ "901-234", "234-567", "345-678", "901-234", "789-012" ] }
    , { optionId = "012", orders = [ "234-567", "345-678", "456-789", "234-567", "901-234" ] }
    , { optionId = "345", orders = [ "345-678", "456-789", "567-890", "345-678", "234-567" ] }
    , { optionId = "678", orders = [ "456-789", "567-890", "678-901", "456-789", "345-678" ] }
    , { optionId = "901", orders = [ "567-890", "678-901", "789-012", "567-890", "456-789" ] }
    , { optionId = "234", orders = [ "678-901", "789-012", "890-123", "678-901", "567-890" ] }
    , { optionId = "567", orders = [ "789-012", "890-123", "901-234", "789-012", "678-901" ] }
    , { optionId = "890", orders = [ "890-123", "901-234", "234-567", "890-123", "678-901" ] }
    , { optionId = "abc2", orders = [ "123-123", "542-64", "789-987", "123-123", "542-64" ] }
    , { optionId = "def2", orders = [ "542-64", "789-987", "234-567", "542-64", "123-123" ] }
    , { optionId = "ghi2", orders = [ "789-987", "234-567", "890-123", "789-987", "542-64" ] }
    , { optionId = "jkl2", orders = [ "234-567", "890-123", "345-678", "234-567", "789-987" ] }
    , { optionId = "mno2", orders = [ "890-123", "345-678", "456-789", "890-123", "234-567" ] }
    , { optionId = "pqr2", orders = [ "345-678", "456-789", "567-890", "345-678", "890-123" ] }
    , { optionId = "stu2", orders = [ "456-789", "567-890", "678-901", "456-789", "345-678" ] }
    , { optionId = "vwx2", orders = [ "567-890", "678-901", "789-012", "567-890", "456-789" ] }
    , { optionId = "yz2", orders = [ "678-901", "789-012", "890-123", "678-901", "567-890" ] }
    , { optionId = "1232", orders = [ "789-012", "890-123", "901-234", "789-012", "678-901" ] }
    , { optionId = "4562", orders = [ "890-123", "901-234", "234-567", "890-123", "678-901" ] }
    , { optionId = "7892", orders = [ "901-234", "234-567", "345-678", "901-234", "789-012" ] }
    , { optionId = "0122", orders = [ "234-567", "345-678", "456-789", "234-567", "901-234" ] }
    , { optionId = "3452", orders = [ "345-678", "456-789", "567-890", "345-678", "234-567" ] }
    , { optionId = "6782", orders = [ "456-789", "567-890", "678-901", "456-789", "345-678" ] }
    , { optionId = "9012", orders = [ "567-890", "678-901", "789-012", "567-890", "456-789" ] }
    , { optionId = "2342", orders = [ "678-901", "789-012", "890-123", "678-901", "567-890" ] }
    ]


countOrders : List Cart -> Int
countOrders carts =
    carts
        |> List.map (\cart -> cart.orders)
        -- List.concat transforme [ [1, 2, 3], [4, 5], [6, 7]]
        -- en [1,2,3,4,5,6,7]
        |> List.concat
        -- On supprimer les doublons avec  un `Set`
        |> Set.fromList
        |> Set.size


-- alternative:

countOrders1 : List Cart -> Int
countOrders1 carts =
    carts
        -- La syntax  `.nomDuChamp` (un point suivi d'un identifiant) est
        -- un raccourci pour la fonction `(\ x -> x.nomDuChamp)`
        |> List.map .orders
        |> List.concat
        |> Set.fromList
        |> Set.size



countOrders2 : List Cart -> Int
countOrders2 carts =
    carts
        -- List.concatMap revient au même que de faire un List.map
        -- suivi d'un List.concat. Sa définition n'est rien d'autre que ça:
        --
        -- concatMap : (a -> List b) -> List a -> List b
        -- concatMap f list =
        --    concat (map f list)
        |> List.concatMap .orders        
        |> Set.fromList
        |> Set.size



test =
    countOrders theCarts == 11
