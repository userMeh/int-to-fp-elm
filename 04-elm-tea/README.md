Ce TP vous introduit l'architecture Elm ("The Elm Architecture" abrégée "TEA").

1. Lire le code source dans `src/Main.elm` et essayer de prédire le comportement du programme.
2. Lancer Elm reactor (en étant dans le dossier `04-elm-tea`):
   ```
   elm reactor
   ```
   et vérifier que le programme se comporte comme vous l'espériez !
3. Quel rôle a le type `Msg` ? Et le type `Model`? À quoi sert `init` ?
   `view` ? Et `update` ? Assurez vous de comprendre les annotations de types
   au-dessus de ces fonctions.
   Reponse:
   - `Msg` le type message est un type qui permet de définir les actions que les utilisateurs peuvent faire sur l'application.
   - `Model` le type model est le type qui gère l'état de l'application.
   - `init` est la fonction qui initialise le model et les variables de l'application.
   - `view` est la fonction qui permet de définir l'interface graphique de l'application.
   - `update` est la fonction qui permet de mettre à jour le model en fonction des actions de l'utilisateur.
4. Rajouter un bouton "Remise à zéro" qui remet le compteur à zéro lorsqu'on clique dessus.
5. Contempler le schéma `tea.png` à côté de ce README et faites le lien avec
   ce que vous avez vu précédemment.
6. Que fait la syntaxe `{ model | count = 5 }` ? Le record `model` est-il modifié ?
   Réponse: La syntaxe `{ model | count = 5 }` permet de modifier le champ `count` du record `model`.
