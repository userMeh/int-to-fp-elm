module AoC2022_1Solved exposing (..)


exampleInput =
    """1000
2000
3000

4000

5000
6000

7000
8000
9000

10000"""


{-| Transforme le contenu d'un "sac à dos"
en une liste d'entier.
Eg.
parseElveGroup """1
2
3""" == [1,2,3]

Note: les lignes qui ne sont pas des entiers sont
ignorées, dans une vraie application, il faudrait
signaler une erreur, faire un log, ... Bref gérer
l'erreur.

-}
parseElveBag : String -> List Int
parseElveBag string =
    string
        |> String.split "\n"
        |> List.filterMap String.toInt


computeAnswer1 input =
    input
        -- on regroupe les "sac à dos" par elfe
        |> String.split "\n\n"
        |> List.map parseElveBag
        -- on a maintenant une valeur bien structurée:
        -- chaque sac est représenté par une `List Int`
        -- et on a une liste de sac, donc:
        -- `List (List Int)`
        --
        -- Pour chaque sac, on va calculer la quantité globale
        -- de calorie
        |> List.map List.sum
        -- Il suffit maintenant de prendre le maximum de chaque sac.
        -- On obtient un `Maybe Int` car dans le cas où la liste
        -- est vide, `List.maximum` ne sais pas quoi renvoyer.
        --
        -- Pour advent of code, on peut juste lire un `Just 1542`
        -- et recopier `1542`. Si on a un `Nothing`, ça ve dire que la liste
        -- des sacs est vide.... Et donc qu'on s'est planté quelque part!
        |> List.maximum


computeAnswer2 input =
    -- Le début est exactement le même que pour le problème 1!
    -- On pourrait l'exraire dans une fonction
    -- parseInput : String -> List Int
    -- qui renvoie le nombre de calorie dans chaque sac à dos.
    -- Reston simple et faisons juste un copié-collé:
    input
        |> String.split "\n\n"
        |> List.map parseElveBag
        |> List.map List.sum
        -- on veut trier la liste par ordre décroissant.
        -- Faire un List.sort la trierait par ordre croissant,
        -- on va donc utiliser List.sortBy pour indiquer qu'on
        -- veut trier selon l'opposé du contenu de la liste.
        --
        -- Alternative:
        -- List.sort |> List.reverse
        -- (mais ça va parcourir 2 fois la liste)
        |> List.sortBy (\caloriesCount -> -caloriesCount)
        |> List.take 3
        |> List.sum


exampleAnswer1 =
    computeAnswer1 exampleInput


exampleAnswer2 =
    computeAnswer2 exampleInput


actualAnswer1 =
    computeAnswer1 actualInput


actualInput =
    """COPIER ICI VOTRE INPUT!
    """
