Sont regroupés ici les concepts clefs à retenir de ce cours.

Tentez de répondre vous même à chacune de ces questions, avant d'aller vérifier sur d'autres sources.

Vous pouvez régulièrement faire un tour ici jusqu'à ce que ces notions soient familières.

## 01 Python Html

**Expliquer ce qu'est DSL**

Et donner au moins 1 exemple.

**Fonction en Python 101**

Écrire une fonction `evil_add` en Python prenant deux paramètres `a` et `b` et renvoyant `a+b+666`.

**Listes en Python 101**

Écrire une liste en python comprenant les éléments `42` (l'entier) et `"Hello world"`.

**Fonction pure (ou référentiellement transparente)**

Contre-exemple: donnez plusieurs exemples de fonctions "non-pure".

**Compréhension de liste ("list comprehension" en anglais)**

Exemple: disons qu'on a une liste de nombre `numbers` en python. Comment créer une liste `triples` qui triple chacun des éléments de `numbers`.

## 02 Elm Html

**Fonction en Elm 101**
Écrire une fonction `evil_add` en Elm prenant deux paramètres `a` et `b` et renvoyant `a+b+666`.

**Listes en Elm 101**

Peut-on créer une liste avec `42` (l'entier) et `"Hello world"` (la chaîne de caractère) en Elm ?
Si oui, faites le, sinon expliquez pourquoi.

**Que fait `List.map` ?**

**Appel de fonctions complexes**

Dans l'expression suivante, quelles variables sont forcément des fonctions ? Combien d'arguments
prennent elles ?

```
a b (c d e) (f (g h) i j k)
```

**Enregistrement ("record" en anglais)**

Définir un _record_ représentant un utilisateur dont le nom est "Charles-Édouard" et
l'âge est 42.

**Accès à un champ d'enregistrement**

J'ai une valeur `user`, comment ai-je accès au champ `age`?

**Annotation de types en Elm 101**

Annotez la fonction `evil_add`

**Types en Elm 102**

Définir un alias de type pour le record représentant un utilisateur comme Charles Edouard.

## 04 Elm TEA

1. Comment appelle-t-on respectivement "l'état" et "les événements" dans TEA ?

2. Dans "The Elm Architecture" quelle est la signature de la fonction `update` ?

3. ```elm
   person = { age = 42, name = "John", address = "Holywood", phone= "+1 666"}
   ```
   Quelle est la syntaxe pour créer un nouveau record qui contient les mêmes données, sauf que John a maintenant 43 ans.
4. Comment peut-on modifier des données en Elm ?

## 05 Calculator

1. Quel type peut-on utiliser pour indiquer qu'un calcul a échoué ? (Par exemple lorsqu'on cherche à convertir en nombre la chaîne de caractères `"Coucou!"`).

2. Écrire une fonction `viewMaybeInt : Maybe Int -> Html msg`, affichant un entier
   s'il y en a un, ou `"Pas d'pot, y a rien là !"` sinon.

3. Comment indiquer un "message d'erreur" lorsqu'un calcul a échoué ?

## 06 Make impossible states impossible

On modélise un processus de chargement avec le type suivant:

```
type alias Model = { isLoading : Bool, dataCorrectlyReceived : Bool }
```

(le champ `dataCorrectlyReceived` peut être à `False` par exemple si on a reçu
`"Coucou"` au lieu d'un entier)

1. Que penser de l'état `{ isLoading = True, et dataCorrectlyReceived = True }`?
2. Proposer une meilleure modélisation ne pouvant pas représenter cet état
   impossible.

## 07 Elm training

1. Quel type utiliser pou représenter un calcul qui a échoué ?

2. Pour chacun des éléments suivants, déterminer s'il s'agit d'un type
   ou d'une valeur: `Maybe Int`, `Just 42`, `Nothing`.
3. Ré-écrire en utilisant une fonction anonyme à la place de `isBig`:

   ```elm
   isBig x = x > 100

   keepBigNumbers numbers =
       List.filter isBig numbers
   ```

4. Ré-écrire en utilisant un pipe `|>`:
   ```elm
   doublePositive numbers =
       List.map (\x -> x*2) (List.filter (\x-> x >0) numbers)
   ```
