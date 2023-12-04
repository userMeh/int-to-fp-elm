# Un peu de technicité

Ce TP commence par quelques éléments du langage, puis d'exercices afin
de gagner en familiarité avec Elm.

## Pipe

Elm possède l'opérateur `|>` (lire "pipe", ou "pizza operator"). Il sert à inverser l'ordre
de la fonction et de la fonction.

Par exemple `String.trim "   bla  "` renvoie `"bla"` (`trim` supprime les espaces).
On l'écrire de façon équivalente : `"  bla   " |> String.trim`.

"Mais ça sert à rien !?", vous vois-je déjà vous exclamer!

L'intérêt apparaît lorsqu'on chaîne plusieurs appels. Version sans pipeline
(on est obliger de lire le plus à l'intérieur puis de remonter vers la gauche pour
voir les opérations : `trim` puis `toInt`):

```elm
clean : String -> Maybe Int
clean input =
    String.toInt (String.trim input)
```

Avec des pipelines (on peut suivre "naturellement" le flot d'exécution):

```elm
clean : String -> Maybe Int
clean input =
    input
        |> String.trim
        |> String.toInt
```

## Lambda (ou fonctions anonymes)

On a déjà rencontré du code similaire :

```elm
double x = 2 * x

evenNumbers =
    List.map double [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
```

`List.map` applique la fonction `double` à chacun des éléments de la liste pour
obtenir `[2, 4, 6, 8, ..., 20]`.

Cette fonction `double` étant trèèèès simple, il est un peu pénible de devoir
la définir séparément, lui trouver un nom... On peut très bien définir une fonction dite
"anonyme", ou encore une "fonction lambda" ("lambda function" en anglais), ou
en condensée "une lambda":

```elm
evenNumbers =
    List.map (\ x -> 2 * x)  [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
```

Cela revient exactement au même !

_Un peu d'entraînement_ :

1. dans le fichier `src/Ex01.elm` utiliser une lambda au lieu de la fonction
   `viewTodo`. Utiliser `elm reactor` pour vous assurer que tout s'affiche
   correctement.
2. dans le fichier `src/Exo02.elm`, compléter la fonction `toAges` pour que la
   variable `test` soit `True`. Pour s'en assurer, lancer `elm repl`
   à la racine de ce dossier, puis dans le repl:

   ```
   import Ex02
   Ex02.test
   ```

   (_note:_ pas
   besoin de quitter/relancer le repl si vous changez votre code. Appeler `Ex02.test` va recharger automatiquement votre code!)
   (vous pouvez aussi appeler `Ex02.toAges [1, 2]` pour tester votre code).

   _Indication_ : la fonction [`String.fromInt`](https://package.elm-lang.org/packages/elm/core/latest/String#fromInt) pourra vous être utile (au passage,
   la doc est assez bien faite, jetez-y un oeil!).

## On mélange et PAF !

Ça fait des beaux piplines fonctionnels ! Dans la dernière expression `List.map (\ x -> 2 * x)  [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]`
on peut parenthéser de cette façon\*:

```
 (List.map (\ x -> 2 * x))  [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
 ^-----------------------^  ^-----------------------------^
          fonction                      argument
```

et donc... utiliser un opérateur "pipe":

```elm
evenNumbers =
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        |> List.map (\ x -> * 2)
```

## Filtrer

Une autre opération commune avec les listes est de filtrer les
éléments qui réponde à un certain critère.

Par exemple, voulant préserver le monde du chaos, écrivons une fonction
qui ne garde que les nombres positifs:

```elm
keepGoodNumbers : List Int -> List Int
keepGoodNumbers numbers =
    List.filter (\ x -> x >= 0) numbers
```

On peut enchaîner pour sommer tous les éléments de la liste:

```elm
sumOfGoodNumbers : List Int  -> List
sumOfGoodNumbers numbers =
    List.filter (\ x -> x >= 0) numbers
        |> List.sum
```

Notez qu'on aurait très bien pu tout chaîner, c'est comme vous préférez:

```elm
sumOfGoodNumbers : List Int  -> List
sumOfGoodNumbers numbers =
     numbers
        |> List.filter (\ x -> x >= 0)
        |> List.sum
```

**Un peu d'entraînement**

1. Dans le fichier Ex03.elm, écrire le corps de fonction `totalLength` comptant
   le nombre de caractères dans tous les éléments de la liste passée en argument.
   Utiliser au moins un `|>`.

   _"Mmmmh, il me manque une fonction sur les String non ?"_ T'as regardé
   [la doc du module `String`](https://package.elm-lang.org/packages/elm/core/latest/String) ?

   Comme pour l'Exo02.elm, vérifier dans `elm repl`:

   ```elm
   import Exo03
   Exo03.test
   ```

   (_rappel:_ pas
   besoin de quitter/relancer le repl si vous changez votre code. Appeler `Ex03.test` va recharger automatiquement votre code!)

2. Maintenant que vous avez atteint un niveau "Plus trop un padawan mais pas
   encore un jedi" en Elm il est temps
   de vous confier une vraie mission pour la survie du monde.

   Plusieurs héros ont candidaté au poste de gardien de la galaxie. Seulement
   pour accéder à ce titre prestigieux, il faut être un héro "légendaire".
   Et la moindre des choses pour être "légendaire" est d'avoir un nom qui
   en impose, c'est dire constitué de strictement plus de 7 lettres.

   Compter le nombre de héros légendaires grâce à la fonction
   `countLegendaryHeroes` dans `src/Ex04/elm`.
   Vérifier votre résultat avec le repl comme précédement.

3. Après votre succès sur le recrutement des gardiens de la
   Galaxie, un magains de jouet vous réclame de l'aide
   (et vu que vous aimez les jouets et les enfants, vous
   allez bosser gratis).

   Ils se retrouvent avec une liste d'articles (les optionsId)
   pas plusieurs commandes (la liste orderIds). Certains orderIds
   sont en double pour un optionId donné, c'est du à une erreur
   de Gérard de la compta (c'est un magasin de jouets, pas une
   école d'informatique, on est indulgents) : chaque orderId ne
   devrait pas apparaître plus d'une fois pour un optionId donné.

   Le magasin veut savoir combien de commandes (orders) sont
   présents dans ces données. Attention un order peut apparaître
   plusieurs dans des optionId différents, il ne faut le compter
   qu'une seule fois.

   _Les conseils du maître Jedi_:

   - C'est un peu plus complexe que les précédents, allez-y
     vraiment par étape en transformant la donnée au fur et à
     mesure.
   - Avez-vous déjà consulté [la doc du module List](https://package.elm-lang.org/packages/elm/core/latest/List)
     et [celle du module Set](https://package.elm-lang.org/packages/elm/core/latest/Set) ?

4. Rendez-vous sur https://adventofcode.com/2022/day/1 et lisez
   le problème. Définissez la fonction `computeAnswer1`
   et vérifiez à l'aide de `elm repl` que `exampleAnswer1` est
   correcte (`24000`).

   Quand l'exemple est ok, connectez-vous sur le site pour récupérer
   votre input que vous pouvez copier dans `actualInput`.

   Une fois que vous avez répondu à la première question, une
   deuxième apparaît... à vous de jouer pour y répondre également !

5. Vous avez terminez le jour 1 ? Bravo, maintenant attaquez vous au jour 2, puis 3 !

\*_Note_: et à ce moment du cours, vos yeux s'illuminent et vous comprenez pourquoi
une fonction à deux arguments est annotée `add: Int -> Int -> Int`. En passant un
premier argument : `add 5` on a juste remplacé le premier `Int`, et donc
`add 5 : Int -> Int` est encore une fonction ! Ce qui nous permet de la placer
après le pipe!
