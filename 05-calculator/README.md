# Calculette et gestion d'erreur

Le but de cet exercice est de créer une calculette simple où l'utilisateur rentre
deux nombres et l'application en affiche la somme.

Cela nous permettra d'aborder la gestion des erreurs dans un langage purement fonctionnel.

1. Lire le code de `src/Main.elm`, les commentaires et anticiper le comportement du programme.
2. Lancer `elm reactor` et vérifier que le programme se comporte comme vous l'attendiez.
3. Explorons un peu le retour de `String.toInt`. Dans le terminal, lancer `elm repl` : c'est
   un interpréteur Elm en ligne de commande. Vous pouvez faire des calculs, définir des fonctions...

   1. Testez un calcul simple comme `41.8 + 0.2`. S'affiche alors `42 : Float`,
      indiquant que `42` est de type `Float`.
   2. Faites plusieurs tests comme `String.toInt "45"` ou `String.toInt "Blabla"`
      et observez le résultat.
   3. Vous devriez voir qu'on a deux types de résultats : `Just <un nombre>` ou
      `Nothing`. Ce `Nothing` indique une absence de valeur. Comment
      traduiriez-vous `Nothing` en Javascript (ou Python, ou C)?
      Réponse: `undefined` en Javascript, `None` en Python, `NULL` en C.
   4. Vous pouvez contruire vous-même ces valeurs, tentez par exemple de
      rentrer `Just 2.3` ou `Just "blabla"` ou simplement `Nothing`.
   5. Pour finir, taper `String.toInt` dans le repl : la signature de la fonction
      apparaît alors.

   **Note :**
   Le type Maybe est défini ainsi:

   ```elm
   type Maybe a = Just a | Nothing
   ```

   Il représente donc soit une présence de valeur (qui sera sous
   la forme `Just <quelquechose>`) ou une absence de valeur
   (`Nothing`).

   Le `a` minuscule dans `Maybe a` indique qu'on peut utiliser ce type
   `Maybe` avec n'importe quel autre type. Par exemple `Maybe Int`
   représente un entier ou une absence d'entier, `Maybe User`
   un utilisateur ou une absence d'utilisateur...

4. Revenir dans le fichier `Main.elm`, et ajouter la possibilité d'entrer un
   deuxième nombre. Pour l'instant on affiche les deux nombres séparément sans
   chercher à les ajouter.
5. Débrouillez-vous pour que la somme des deux nombres soit affichée lorsque
   les deux entrées utilisateur sont des nombres (on pourra par exemple imbriquer
   des `case`).
6. Dans notre mini calculette, on passe d'un string à un entier, on doit donc
   vérifier que la string est dans format acceptable avant de pouvoir faire le
   calcul. Dit autrement, on doit transformer une donnée avec peu de structure
   en une donnée plus structurée. Cette opération est généralement dénommé
   sous le terme de "parsing". Une fois cette étape de parsing effectuée, on
   peut se concentrer sur le métier sans se poser la question de la validité
   nos données.

   Extrayons cette étape de parsing: créer une fonction
   `parseInput : Model -> Maybe { number1 : Int, number2: Int}`
   qui renvoie `Nothing` si `number1Input` ou `number2Input` n'est pas un entier
   et `Just {number1=... , number2=...}` dans le cas contraire.

7. Utiliser cette fonction `parseInput` dans la fonction `view`.
   Pour ce petit exemple, l'intérêt d'avoir extrait cette fonction `parseInput`
   est faible, mais cela prend tout son sens dans une application plus complexe.
8. On rajoute une contrainte: if faut que les champs contiennent
   uniquement des nombres positifs (car les nombres négatifs sont la
   manifestation du diable, c'est bien connu).

   Aller, c'est cadeau, utilisez cette fonction dans votre code
   pour enforcer cette contrainte:

   ```elm
   toPositiveInt : String -> Maybe Int
   toPositiveInt string =
       case String.toInt string of
           Just number ->
               if number >= 0 then
                   Just number
               else
                   Nothing
           Nothing ->
               Nothing
   ```

9. Ok cool, mais avec toutes ces conditions, on n'a plus de moyen
   de savoir la quelle n'a pas été respectée.

   Le soucis vient du fait que le type `Maybe Int` représente une
   valeur ou _une absence de valeur_, sans plus d'indication.
   On peut alors utiliser un autre type, le type `Result String Int`:
   si tout c'est bien passé, on aura quelque chose comme`Ok 42`
   (au lieu d'un `Just 42`).

   Si on a une erreur on aura quelque chose comme `Err "Le nombre doit être positif"` (au lieu de `Nothing`; notez que cette fois
   on sait pourquoi il y a un erreur).

   **Note :**
   Le type `Result` est défini ainsi:

   ```elm
   type Result error value = Err error | Ok value
   ```

   Encore une fois, les types en minuscule `error` `value` peuvent
   être remplacés par n'importe quels autres types. On peut également
   faire un `case` sur une valeur de ce type:

   ```elm
   case someResult of
       Ok value -> ...
       Err err -> ...
   ```

   À vous de jouer : modifier l'annotation de type pour avoir
   `toPositiveInt : String -> Result String Int`.
   Modifier alors la fonction pour qu'elle renvoie soit `Ok <un nombre>`
   soit `Err "Ce n'est pas un nombre"`, soit `Err "Le nombre doit être positif"`.

10. Modifier alors le type de retour de `parseInput` pour qu'il  
    soit aussi `Result String { number1 : Int, number2: Int}`. Pour
    les erreurs, ajoutez devant s'il s'agit du champ 1 ou 2.
