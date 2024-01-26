# JSON

Cette partie s'intéresse à la communication entre Elm et "l'extérieur". La plupart
du temps, on utilise le format JSON.

## L'encodage -- Oh look, it's a DSL again!

On a une valeur en Elm et on veut "l'encoder" en JSON.

La libraire standard de Elm inclut (heureusement !) une librairie pour
manipuler ce format de donnée. Le module s'appelle `Json.Encode` pour l'encodage
qu'on importera dans les exercices comme `JE` (cf le fichier `src/Ex1.elm`).

Ce format JSON est représenté par un type `Value` qu'on ne peut
pas inspecter "directement" (ce qui explique que les tests pour l'exercice 1
puissent paraître un peu compliqués pour ce qu'on veut tester).

Commençons un petit test : en vous plaçant dans le dossier où se situe ce README,
ouvrez un "repl" elm:

```
elm repl
```

Puis une fois dedans importez ce module et regardons une première fonction simple:

```
import Json.Encode as JE exposing (Value)
JE.int
```

`JE.int : Int -> Value` se lit "cette fonction transforme un entier en une valeur JSON.

Essayons avec une valeur concrète:

```elm
JE.int 5
```

Oups, on a un `<internals>`, on ne peut pas aller "voir" dedans. On peut utiliser
`JE.encode` pour transformer ça en chaîne de caractères:

```elm
myJsonValue = JE.int 5
JE.encode 4 myJsonValue
```

Pour la suite, vous aurez besoin de la documentation vous détaillant toutes
les fonctions à disposition (ne lisez pas tout d'un coup, allez chercher ce dont
vous avez besoin au fur et à mesure des exercices):
https://package.elm-lang.org/packages/elm/json/latest/Json-Encode .

Vous pouvez maintenant vous lancer dans l'exercice `src/Ex1.elm`. Il faut écrire
un encodeur pour chacun des types présentés. Sauf mention contraire, il faut
encoder en JSON en nommant les champs en JSON de la même façon que les champs en Elm.

Pour tester, toujours dans le repl:

```
import Ex1
Ex1.testAge
```

qui doit afficher :

```
{ test1 = True
, test2 = True
}
```

Si certains tests échouent, vous pouvez utiliser `JE.encode 4 (Ex1.encodeAge 45)`
pour débugger. On rappelle qu'il est inutile de re-importer le module dans le repl
si vous l'avez modifié, l'appel à
`Ex1.testAge` fera toujours référence à la version actuelle (il faut quand même
avoir sauvegardé le fichier !).

**À vous de jouer : implémentez tous les encodeurs proposés de l'exercice 1!**

## Les combinateurs

Ce module implémente (une version simple) des **combinateurs**. On a
quelques fonctions permettant de construire les valeurs de base de JSON:

- `JE.int`, `JE.float` pour le type JSON `number`,
- `JE.string` pour le type JSON `string`,
- `JE.null` pour le type JSON `null` (constitué d'une seule valeur).

Et ces différentes valeurs peuvent être _combinés_ avec des **combinateurs**:

- `JE.list` pour construire des tableaux de JSON,
- `JE.object` pour construire des objets JSON.

Ce module `Json.Encode` définit donc un "Domain Specific Language" (DSL)
à l'intérieur de Elm pour construire des valeurs JSON.

Il est important de noter que l'on peut manipuler de la même manière une valeur "de base" (comme une chaîne de caractères ou un nombre) ou une valeur complexe de la même façon : dans tous les cas, ce sont des Value. Cela permet une composition facile des fonctions. Par exemple, les fonctions encodePerson et encodeProduct peuvent être utilisées sans difficulté pour construire encodeOrder.

### Une impression de déjà vu ?

Ce concept nous est déjà familier avec le module `Html`.
Il existe un seul constructeur "de base": la fonction `H.text`, qui transforme
une `String` en `Html`.

De plus, plusieurs combinateurs sont disponibles, tels que :

- `H.div` pour une balise `<div>`
- `H.ul` pour une balise `<ul>`
- ...

Toutes ces fonctions prennent une liste de `Html` en argument représentant les
enfants de ces balises. Comme pour `Value`, peu importe comment sont
composés ces valeurs, on peut alors constuire par exemple un `menu : Html` et
un `body : Html` tous deux potentiellement très complexes et les associer
avec `H.div` pour en faire une page complète.

_Note :_ toutes ces fonctions `H.div`, `H.ul`, ... sont toutes définies à partir
de la fonction `H.node`. Voici un exemple d'utilisation de cette fonction:

```elm
example =
    H.node "customTag"
        [ HA.class "card" ]
        [ H.text "Salut" ]
```

Sera transformé en :

```html
<customTag class="card">Salut</customTag>
```

(on peut bien sûr remplacer `customTag` par n'importe quel nom valide pour une
balise HTML, comme `div`, `ul`, `a`, ...).

On a aussi rencontré ce concept lors du chapitre 03-homework-canvas dans la
librairie `drawlib` et le type `Shape`:

- les éléments de base sont les polygones et les cercles
- il y a un seul combinateur : la fonction `group`

## Décodage de JSON

Dans cette partie on cherche à faire le cheminement inverse: on a du JSON
qu'on veut transformer en une valeur Elm. On construit pour cela des `Decoder`.

L'idée est que le JSON venant de "l'extérieur", il peut avoir n'importe quelle
"forme"/"structure". Avant tout traitement on va alors s'assurer que
les données qu'on reçoit sont du type attendu pour les transformer en une valeur
Elm. Si ce n'est pas le cas, on peut alors afficher un message d'erreur à
l'utilisateur.

Le module `Json.Decode` est bâti selon une logique de combinateurs, comme décrits
plus haut. Voyons déjà comment décoder les types "de base" (qui seront après
"combinés" pour décoder des types arbitrairement complexes).

### Décodeurs basiques

Ouvrons un repl dans le dossier `09-json`:

```elm
import Json.Decode as JD
myDecoder = JD.int
```

On a défini un décodeur `myDecoder`. Vous pouvez constater que son type est
`Decoder Int` qui indique que la valeur Elm produite sera un entier (`Int`).

Utilisons le ce décodeur:

```elm
JD.decodeString myDecoder "42"
```

On obtient `Ok 42`, le `Ok` indiquant que tout c'est bien passé.

Faisons le échouer en indiquant une string JSON au lieu d'un entier:

```elm
JD.decodeString myDecoder "\"Salut\""
```

(note : dans la chaîne `"\"Salut\""` on veut représenter
la valeur JSON `"Salut"` contenant elle-même des guillemets; on doit
donc "échapper" les guillemets à l'intérieur, d'où le `\"`.)

On obtient la valeur suivante:

```elm
Err (Failure "Expecting an INT" <internals>)
```

Notez qu'en Elm il n'y a pas de notion d'exception (qu'on oublie très facilement
d'attraper). Une erreur est représenté par une valeur `Err <description du problème>`.

Le message ici est explicite : `myDecoder` s'attend à avoir un entier et on lui
file une string à la place!

Nous verrons dans le prochain TP une façon de traiter ce message d'erreur,
ce TP s'intéresse davantage à la création des décodeurs.

### Un premier pas vers la composition

Continuons notre exploration: la plupart du temps, nous voulons récupérer
des valeurs qui sont à l'intérieur d'un objet, par exemple récupérer l'âge
de Sébastien : `{ "name": "Seb", "age": 42 }`.

Pour ce cas, on utilise `JD.field`, essayons dans le repl, indiquons qu'on cherche
un `Int` dans le champ `"age"` :

```elm
ageDecoder = JD.field "age" JD.int
JD.decodeString ageDecoder """{ "name": "Seb", "age": 42 }"""
```

(note: on peut utiliser `"""` en Elm comme délimiteur de chaînes de caractères;
dans ce cas, il est inutile d'échapper les guillemets `"` ce qui est fort
pratique pour écrire du JSON).

> Attends 2 secondes... `ageDecoder`, c'est un `Decoder Int`... Mais le dernier
> argument de `JD.field`, semble aussi être un `Decoder`... Cela signifierait-il
> qu'on peut les enchaîner ?

```
JD.field "age" JD.int
               ^^^^^^
             Decoder Int
^^^^^^^^^^^^^^^^^^^^^^
      Decoder Int
```

Oui ! C'est le principe des combinateurs ! On peut par exemple aller chercher
l'âge au milieu de la commande suivante :

```json
{
  "person": { "name": "Seb", "age": 42 },
  "product": { "name": "Table", "price": 58 }
}
```

Ça donnerait :

```elm
deepAgeDecoder = JD.field "person" (JD.field "age" JD.int)
orderInJson = """{
  "person": { "name": "Seb", "age": 42 },
  "product": { "name": "Table", "price": 58 }
}"""

JD.decodeString deepAgeDecoder orderInJson
```

Allez, c'est parti pour l'exercice `Ex2.elm`.

### Le retour de `map`

Vous souvenez de `List.map` ? Cette fonction permet d'appliquer
une transformation à tous les éléments d'une liste.

Par exemple :

```elm
List.map (\ x -> x + 3 ) [1, 5, 17]
```

donne `[4, 8, 20]`. `List.map` nous permet donc de modifier
ce qui se trouve "à l'intérieur" de la liste. Sa signature
est la suivante :

```elm
List.map :
    ( a -> b) -- fonction à appliquer
    -> List a -- liste sur laquelle appliquer la fonction
    -> List b -- liste "résultat"
```

Nous avons une fonction trèèèès similaire avec les décodeurs:

```elm
JD.map :
    ( a -> b)    -- fonction à appliquer en cas de de succès
    -> Decoder a -- décodeur qu'il faut appliquer en premier
    -> Decoder b -- décodeur "résultat"
```

Testons ça sur un exemple simple dans le repl:

```elm
myIntDecoder = JD.map (\ x -> x + 3) JD.int
JD.decodeString myIntDecoder "5"
```

Vous devriez obtenir `Ok 8`. Par contre si on tente de décoder autre
chose qu'un entier:

```elm
JD.decodeString myIntDecoder "\"Salut\""
```

Vous devriez obtenir une erreur.

Cet exemple est bien sûr artificiel (je ne vois pas de cas concret
où on voudrait modifier une valeur de cette façon...), en général
on se sert de `JD.map` pour "encapsuler" une valeur. Par exemple:

```elm
myScoreDecoder =
    JD.map
        (\decodedScore -> { score = decodedScore })
        JD.int

JD.decodeString myScoreDecoder "5"
```

Devrait donner `Ok {score = 5}` (note : on a ici utilisé 2 noms différents
pour l'argument de la fonction anonyme et pour le nom du champ `decodedScore`
et `score` afin de faciliter la compréhension; en pratique on préférera souvent
donner le même nom).

Autre utilisation, pour "encapsuler" dans un "constructeur" d'un type "union".

```elm
myJustDecoder =
    JD.map
        (\score -> Just score)
        JD.int

JD.decodeString myJustDecoder "5"
```

Devrait donner `Ok (Just 5)`.

**Aller, un peu de pratique avec l'exo 3!**

### Combiner plusieurs décodeurs

Ok, maintenant on peut construire ` { age = 42 }` ou
`{ name = "Sébastien" }` à partir de
`{ "name": "Sébastien", "age": 42 }`. Mais on aimerait
bien faire les 2 en même temps, c'est à dire obtenir
`{ name = "Sébastien", age = 42 }`.

On peut utiliser `map2` pour cela :

```elm
JD.map2
    (\ decodedName decodedAge -> { name = decodedName, age = decodedAge })
    (JD.field "name" JD.string)
    (JD.field "age" JD.int)
```

Il y a plusieurs fonctions `map2`, `map3`, ... `map8`. Pour les records
avec plus de 8 champs, on peut utiliser une autre technique mais que nous
n'aurons pas le temps d'explorer dans ce cours.

> Aparté : écrire la lambda
>
> ```elm
> (\ decodedName decodedAge -> { name = decodedName, age = decodedAge })
> ```
>
> peut être ennuyant et répétitif.
>
> Vu que vous êtes sympas, je vais vous donner une astuce.
> En fait quand on définit un "type alias" qui est un record comme:
>
> ```elm
> type alias Person = { name : String, age: Int }
> ```
>
> on crée 2 choses :
>
> - un type `Person` qui est un synonyme de `{ name : String, age : Int}`,
> - une fonction `Person : String -> Int -> Person` (le premier `Person` désigne
>   la fonction le second désigne le type).
>
> Cette fonction `Person` est équivalente à
>
> ```elm
> \ name age -> { name = name, age = age }
> ```
>
> donc on peut écrire le décodeur
> plus simplement :
>
> ```elm
> personDecoder =
>     JD.map2 Person
>         (JD.field "name" JD.string)
>         (JD.field "age" JD.int)
> ```

**C'est parti pour l'exo 4!**

### "Et puis" l'âge est forcément positif

On veut s'assurer que les âges qu'on décode sont positifs, et faire
échouer le processus sinon.

Il faut donc qu'on puisse dire:

```
tente de décoder un entier
  PUIS dans le cas où tu as réussi,
       SI cet entier est positif,
       ALORS on cet entier est un succès
       SINON on a un échec
```

Pour l'instant, on a uniquement vu `JD.map` qui transforme un "succès"
en un autre "succès" : dans le pseudo code ci-dessus, on peut donc exprimer
le `ALORS` mais pas le `SINON`.

Il faut alors dégainer\* :

```elm
JD.andThen :
    ( a -> Decoder b) -- à partir d'un a, détermine si c'est un échec ou succès
                      -- et renvoie un b
    -> Decoder a  -- Décodeur à exécuter en premier
    -> Decoder b  -- Décoder "résultat"
```

Concrètement sur notre exemple de vérification d'âge :

```elm
ageDecoder =
    JD.andThen
        (\ decodedInt ->
            if decodedInt >= 0 then
                JD.succeed decodedInt
            else
                JD.fail "l'âge doit être positif"
        )
        JD.int
```

Cela peut être un peu dur à lire car en lisant de haut en bas, on lit
d'abord la transformation à appliquer avant de lire ce qu'on veut
décoder en premier. On aura donc souvent tendance à utiliser l'opérateur
pizza `|>` pour avoir un sens de lecture plus naturel:

```elm
ageDecoder =
    JD.int
        |> JD.andThen
            (\ decodedInt ->
                if decodedInt >= 0 then
                    JD.succeed decodedInt
                else
                    JD.fail "l'âge doit être positif"
            )
```

(cela produit exactement le même décodeur que précédemment, mais présenté
différemment).

Testons le dans le repl:

```elm
JD.decodeString ageDecoder "42"
JD.decodeString ageDecoder "-42"
```

Le premier devrait renvoyer `Ok 42` le second un échec avec notre message d'erreur
`l'âge doit être positif`.

Bien sûr ce `ageDecoder` est maintenant un décodeur comme un autre et
on peut l'utiliser pour décoder une personne :

```elm
JD.map2
    (\ decodedName decodedAge -> { name = decodedName, age = decodedAge })
    (JD.field "name" JD.string)
    (JD.field "age" ageDecoder)
```

> question : quelle est la seule différence par rapport au décodeur précédent
> d'une personne ?

**Allez hop, on fonce sur l'exo 5.** Comment ça c'est l'heure de la pause ?
J'veux pas le savoir, au boulot !

### "Et puis" on va décoder des types "union" simples

Une autre utilisation typique de `andThen` est pour décoder
un type union simple comme :

```elm
type Color
    = Red
    | Yellow
    | Purple
```

Imaginons qu'on encode en JSON ces couleurs en français (et pourquoi pas ?)
par exemple `"rouge"`, `"jaune"` et `"violet"`. On veut donc d'abord
décoder une string puis en fonction de celle-là renvoyer la bonne couleur.

```elm
colorDecoder : JD.Decoder Color
colorDecoder =
    JD.string
        |> JD.andThen
            (\decodedColor ->
                case decodedColor of
                    "rouge" ->
                        JD.succeed Red

                    "jaune" ->
                        JD.succeed Yellow

                    "violet" ->
                        JD.succeed Purple

                    _ ->
                        -- tous les autres cas
                        JD.fail ("couleur inconnue : " ++ decodedColor)
            )
```

> Vous remarquerez qu'encore une fois, on la représentation en JSON
> est complètement découplée de la représentation des types en Elm.

### "Et puis" on va décoder des types "union" complexes

Avant d'aller plus loin, arrêtons nous sur `JD.succeed`. Sa signature est:

```elm
JD.succeed : a -> Decoder a
```

cette fonction peut prendre une valeur de n'importe quel type
pour la transformer en un décodeur qui retournera toujours cette
valeur comme succès.

Par exemple (à exécuter dans le repl) :

```elm
always42 = JD.succeed 42
JD.decodeString always42 "78"
JD.decodeString always42 "\"Salut\""
JD.decodeString always42 """{ "name" : "Seb" }"""
```

À chaque fois, on obtient `Ok 42`.

De la même façon `JD.fail : String -> Decoder a` produira un décodeur
qui échoue toujours avec un certain message d'erreur:

```elm
alwaysFail = JD.fail "Essaie encore"
JD.decodeString alwaysFail "78"
JD.decodeString alwaysFail "\"Salut\""
JD.decodeString alwaysFail """{ "name" : "Seb" }"""
```

À chaque fois, le décodeur retourne la même erreur "Essaie encore" (toute
ressemblance avec la gestion d'erreurs dans Windows est tout à fait volontaire).

> Bon, très bien, on a donc ces décodeurs qui soit échouent tout le temps
> soit réussisse tout le temps, pourquoi tu nous bassines avec ça ?

J'aimerais juste insister sur un point : dans tous les cas, ce sont des
**décodeurs**. Donc partout où on les utilise, on pourrait très bien
utiliser d'autres décodeurs plus complexes.

Revenons maintenant sur les types "union" avec un exemple un peu plus évolué.
Par exemple prenons le type que nous avions utilisé dans l'exo 1:

```elm
type Shape
    = Point
    | Square { side : Float }
    | Rect { width : Float, length : Float }
```

Que nous encodions d'un de ces façons :

```json
{ "kind": "Point" }

{ "kind": "Square", "side": 5 }

{ "kind": "Rect", "width": 10, "length": 32 }
```

Donc comme pour les couleurs, on va d'abord décoder une string (le champ `kind`), PUIS :

- Si c'est `"Point"`, pas de soucis, on peut dire qu'on a réussi à décoder la
  valeur Elm `Point`
- Si c'est `"Square"`, le travail n'est pas fini, il faut aller voir si on a un
  champ `side` et dans ce cas on peut encore potentiellement échouer.
- Si c'est `"Rect"`, le travail n'est pas fini non plus, il faut aller voir si on
  a un champ `width` et un champ `length`.

Ce qui donne le décodeur suivant:

```elm
shapeDecoder : Decoder Shape
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

```

C'est peut-être compliqué à lire, on peut bien sûr le découper :

```elm
shapeDecoder : Decoder Shape
shapeDecoder =
    JD.field "kind" JD.string
        |> JD.andThen
            (\kind ->
                case kind of
                    "Point" ->
                        JD.succeed Point

                    "Square" ->
                        squareDecoder

                    "Rect" ->
                        rectDecoder

                    _ ->
                        JD.fail ("unknown kind: " ++ kind)
            )

squareDecoder=
    JD.field "side" JD.float
        |> JD.map (\side -> Square { side = side })


rectDecoder =
    JD.map2 (\width length -> Rect { width = width, length = length })
        (JD.field "width" JD.float)
        (JD.field "length" JD.float)
```

**Allez, en route pour le dernier exercice de ce TP : le 6 !**

\*\*Et s'il vous reste du temps, un exo bonus, le 7!

\* Et oui, les plus connaisseurs d'entre vous auront reconnus l'opérateur "bind"
des fameuses monades!
