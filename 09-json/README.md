# JSON

Cette partie s'intéresse à la communication entre Elm et "l'extérieur". La plupart du temps, on utilise le
format JSON, ["faute de mieux"](https://gist.github.com/evancz/1c5f2cf34939336ecb79b97bb89d9da6).

On commence par le sens Elm -> JSON (les "encodeurs") avec des exercices pratiques, puis un peu de théorie en faisant
un petit détour par HTML (What??!). On enchaîne avec les conversion JSON -> Elm (les "décodeurs") basiques "en pratique",
on reboucle sur la théorie et on finit avec de la pratique sur des décodeurs "complets".

## L'encodage -- Oh look, it's a DSL again!

On a une valeur en Elm et on veut "l'encoder" en JSON.

La libraire standard de Elm inclut (heureusement !) une librairie pour
manipuler ce format de donnée. Pour l'utiliser, il faut tout de même l'installer en
entrant la commande suivante dans le terminal à la racine de l'application
(par exemple dans le dossier `09-json` pour notre cas) :

```
# cette installation a déjà été faite pour ce projet, inutile de le refaire :)
elm install elm/json
```

Le module s'appelle `Json.Encode` pour l'encodage
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

Pour la suite, vous aurez besoin de la documentation : vous détaillant toutes
les fonctions à disposition: https://package.elm-lang.org/packages/elm/json/latest/Json-Encode
(ne lisez pas tout d'un coup, allez chercher ce dont vous avez besoin au fur et
à mesure des exercices).

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

Si certains tests échouent, vous pouvez utiliser `JE.encode 4 (Ex1.encodeAge 45)` pour débugger.

À vous de jouer : implémentez tous les encodeurs proposés !

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
