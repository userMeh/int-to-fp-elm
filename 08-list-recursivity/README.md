# Liste et récursivité

## Les listes

Les listes en Elm sont "homogènes", elles ont toutes le même type.

Voici les opérations courantes:

- une liste vide : `[]`
- ajouter deux listes avec `++` : `[1,2,3] ++ [4,5,6]` donne `[1,2,3,4,5,6]`.
- ajouter un élément au début d'une liste avec `::`: `1:: [2,3]` donne `[1, 2,3]`.

Un point intéressant avec l'opérateur `::` est qu'il peut s'enchaîner: `1::2::3::[]`
est une autre notation pour `[1,2,3]`.

Pourquoi j'insiste sur ce `::`? Eh bien car il permet également de
faire un "pattern matching" sur une liste\*:

```elm
premierElement : List String -> String
premierElement strings =
    case strings of
        [] ->
            "Oh c'est triste, la liste est vide :/"
        first :: others ->
            first
```

Prenons plusieurs cas:

- si on appelle `premierElement` avec une liste vide `[]`,
  on va rentrer dans le premier cas et donc renvoyer `"Oh c'est triste ..."`.
- si on appelle `premierElement` avec `["salut"]` (qui s'écrit également
  `"salut"::[]`), on rentre dans le second cas avec `first` prenant la valeur
  `"salut"` et `others` prenant la valeur `[]`.
- si on appelle `premierElement` avec `["salut", "c'est", "cool"]`
  (qui s'écrit également `"salut" :: ["c'est", "cool"]`),
  `first` prendra encore la valeur `"salut"` et `other` prendra
  la valeur `["c'est", "cool"]`.

On peut ainsi "destructurer" la liste pour sélectionner les 2, 3, 4 premiers éléments:

```elm
sumFirstTwo : List Int -> Int
sumFirstTwo ints =
    case ints of
        [] -> 0
        first :: [] -> first
        first :: second :: others -> first + second
```

Au passage on remarque que `others` n'est pas utilisé, on peut donc
le remplacer par `_` (prononcer "wild card") qui signifie "on ne s'intéresse pas
à ce qu'il y aura ici":

```elm
sumFirstTwo : List Int -> Int
sumFirstTwo ints =
    case ints of
        [] -> 0
        first :: [] -> first
        first :: second :: _ -> first + second
```

**Un peu d'entraînement**

1. Dans le fichier `Ex01.elm`, en utilisant un pattern matchin,
   écrivez la fonction `firstElement`
   qui.... renvoie le premier élément de la liste passé en paramètre
   (ou `Nothing` si la liste est vide !).

   Valider votre code en lançant `elm repl` dans ce dossier puis:

   ```
   import Ex01
   Ex01.tests
   ```

   qui doit afficher `{ test1: True, test2 : True, test3: True }` (_note:_ pas
   besoin de quitter/relancer le repl si vous changez votre code. Appeler `Ex01.tests` va recharger automatiquement votre code).

   _Note_ : cette fonction est dans la bibliothèque de base sous le nom
   `List.head : List a -> Maybe a`. La seule chose qui change est qu'on
   a une `List a` au lieu d'une `List Int`. Le `a` minuscule ici désigne
   "n'importe quel type".

   Donc on peut utiliser `List.head` avec une
   liste de `Int`, de `String` ou de `User`. Ça se comprend bien :
   on peut prendre le premier élément d'une liste quelque soit son type!

2. Dans le fichier `Ex02.elm` on chercher à transformer une chaine de la forme `"patate:bidule"`
   en une valeur structurée `{key = "patate", value: "bidule"}`.
   Implémenter `toKeyValue` en utilisant `String.split ":"` puis un pattern matching.

   Validez votre code également dans le repl.

## Récursivité

Vous l'aurez peut-être remarqué, en Elm, il n'y a pas de boucle
`for` ou `while`. Pour simuler ces structures de contrôle, on
utilise la récursivité. Et pour les ça tombe bien car leur
structure est récursive !

Je m'explique: pour décrire ce qu'est une liste, de façon synthétique
on peut dire:

```
une liste est :
    * soit une coquille vide (notée [])
    * soit un élément suivi d'une liste
```

> Mais, mais, .... mais tu utilises la notion de liste pour définir une liste
> ça va pas là!

C'est justement ce qu'on appelle une définition "récursive". Il faut voir qu'à
un moment donné on s'arrête sur la coquille vide. On peut illustrer
grâce au schéma suivant (lire en partant de la droite):

```
  élément élément
      |    |
      v    v
 4 :: 5 :: 6 :: []
     │    │    vvvv
     │    │    liste (coquille vide)
     │    vvvvvvvvv
     │    liste (élément suivi d'une liste)
     vvvvvvvvvvvvvv
     liste (élément suivi d'une liste)


```

Au début on a une coquille vide (c'est une liste). On y
ajoute devant l'élément 6, constituant la liste `[6]`.
Devant cette liste, on ajoute l'élément 5, constituant la
liste `[5, 6]`, etc, ...

Comprendre cette structure va nous permettre de facilement écrire
des fonctions récursives sur les listes. Elles se décomposeront
quasiment toute de la même manière:

- gérer le cas de la coquille vide (le cas de base),
- gérer le cas où on a un élément suivi d'une liste.

**Exemple**

On va recoder la fonction `List.length` donnant la longueur
d'une liste.

1. dans le cas de la coquille vide, la longueur est `0`
2. dans le cas d'un élément suivi d'une autre liste, la longueur est 1 PLUS la
   longueur de cette autre liste.

> Encore une fois tu utilises la notion de longueur pour calculer ... la  
>  longueur... ça se mord la queue !

Eh bien non, car à chaque fois que je passe par 2., la longueur de
la liste diminue donc à un moment je vais tomber sur le cas "coquille
vide", donc je ne tournerai pas en rond.

Voyons ça en code:

```elm
length : List a -> Int
length list =
    case list of
        [] -> 0
        first :: others -> 1 + length others
```

Si applique cette fonction sur `[4,5,6]`, on va avoir successivement:

```elm
length [4,5,6] = 1 + length [5, 6]
               = 1 + 1 + length [6]
               = 1 + 1 + 1 + length []
               = 1 + 1 + 1 + 0
```

(ce qui fait bien 3, ouf tout va bien!)

**Un peu d'entraînement**
Ouvrez le fichier `Ex03.elm`. Il contient plusieurs fonctions dont il faut
compléter l'implémentation (la plupart de ses fonctions font partie de la
module standard `List` mais le jeu est de les recoder ici!).

Pour tester, comme précédemment, lancer `elm repl` puis:

```
import Ex03
Ex03.testsMember
```

(pour tester `member`, `Ex03.testsAny` pour tester `any`.... bref vous voyez le topo).

\* Le nom français du "pattern matching" est "filtrage par motif"... Que peu de monde utilise
même en France... Donc déso Molière et Voltaire, on speakera Frenglish.
