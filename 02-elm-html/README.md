# À la découverte d'Elm : la vue !

Nous allons ici reproduire à peu près le même exercice qu'on a fait en python,
mais en utilisant Elm pour s'habituer à sa syntaxe.

Pour lancer le projet ([il faut avoir installé Elm avant](https://guide.elm-lang.org/install/elm.html) -- ne faites que la partie "Install"):

```
elm reactor
```

Vous pouvez maintenant accéder à http://localhost:8000/src/Main.elm. Vous devrez recharger la page à chaque fois que vous faites des modifications.

Pour simplifier le processus, toutes les écrans sont regroupés dans une seule page
et séparés par une bande rouge. Il n'y a pour l'instant une page d'accueil et une page
"présentation" (qui sera à compléter).

## Exercices

1. Se rendre sur le site et ouvrir l'inspecteur de code (F12 sur la plupart des
   navigateurs). Faire la correspondance entre le HTML affiché dans le navigateur
   et le code Elm dans `src/Main.elm`.
2. Maintenant on va ajouter du contenu dans la page `aboutMePage` qui est déjà créée.
   Pour l'instant on s'embête pas, copiez-collez le contenu de `homeScreen` et
   changez les phrases `Welcome to the site's content` et
   `This is where your content goes` par quelques données sur vous (genre "Je
   m'appelle Archibald, j'ai 12 ans" ou "je suis ingénieur informaticien, j'aimeuh
   les ordinateurs... windows 95 !").
3. Hum hum, ça commence à devenir touffu! Regardons bien ce qui change entre ces 2
   définitions: juste le contenu des pages. À défaut d'avoir un contenu
   intéressant, organisons notre code de façon potable : créez une fonction
   `layout content = ...` pour que la fonction `homeScreen` ressemble à (là encore, vous êtes encouragés à utiliser les touches "ctrl" "c" et "v" de votre clavier\*\*) :

   ```elm
    homeScreen =
        layout
            [ H.p
                []
                [ H.text "Welcome to the site's content." ]
            , H.p
                []
                [ H.text "This is where your content goes." ]
            ]
   ```

   Bien sûr faites un truc similaire pour `aboutMeScreen` en utilisant la même
   fonction `layout`.

4. Rajoutez un nouvel écran `thingsToKnowScreen` utilisant la fonction `layout`
   définie précédemment. Pour le contenu, on se contentra d'une liste vide. Pensez à l'ajouter dans le main :
   ```elm
        ...
        , homeScreen
        , screenSeparator
        , aboutMeScren
        , screenSeparator    --  <--  ajouter ceci!
        , thingsToKnowScreen --  <--  ajouter ceci!
        ]
   ```
5. Écrire une fonction `viewCard text = ...` prenant une string en argument et
   construisant une "carte" en HTML. Par exemple en appelant `viewCard "Salut !"`
   on doit avoir le HTML suivant:
   ```html
   <li class="p-3 rounded shadow border-l-4 border-solid border-blue-500">
     Salut !
   </li>
   ```
6. Voici une liste de faits:

   ```elm
    facts =
        [ "En 2023, la température de la terre a augmenté de 1.2°C par rapport à l'ère pré-industrielle"
        , "La hausse des températures induit une perturbation du cycle de l'eau : plus de sécheresses, mais aussi plus de pluies torrentielles"
        , "Un aller-retour en avion Paris New York émet 1.75 tonne de CO2"
        , "Il y 20 000 ans, la température était 5°C en-dessous de celle de l'ère pré-industrielle et les mers étaient 120m plus basses."
        , "Pour respecter les accords de Paris et rester sous les 2°C de réchauffement, il faut que chaque personne émette 2 tonnes d'équivalent CO2 par an."
        , "L'empreinte carbonne annuelle d'un Français est de 9 tonnes d'équivalent CO2",
        , "On peut baisser nos émissions de gaz à effet de serre significativement en mangeant moins de viande"
        ]
   ```

   Copiez-collez cette liste dans votre code.

7. On va afficher la liste précédente à l'aide de balises `ul` et `li`. Le HTML généré doit ressembler à:

   ```html
   <ul>
     <li>En 2023, ...</li>
     <li>La hausse ...</li>
   </ul>
   ```

   On veut donc appliquer la fonction `viewCard` a chacun des éléments de la liste
   `facts` en utilisant la fonction `List.map`:

   ```elm
   List.map viewCard facts
   ```

   Affichez donc toutes ces cartes dans une jolie balise
   `<ul class="flex flex-col space-y-8">`.

8. On veut ajouter des informations aux faits : une image et une source. On va donc
   utiliser un _record_ ("enregistrement" en français mais malheureusement personne
   ne dit ça). Ici on aura 3 champs dans notre _record_ : `description`, `imageUrl` et `source`. Un "fait" s'écrira alors de cette manière :

   ```elm
   { description = "Bla bla quo bu ga bu zo meu"
   , imageUrl = "https://monimage.com/super-image.jpg"
   , source = "https://c-est-pas-moi-qui-le-dit.com"
   }
   ```

   Remplacez donc la liste par

   ```elm
   facts =
        [ { description = "En 2023, la température de la terre a augmenté de 1.2°C par rapport à l'ère pré-industrielle"
        , imageUrl = "https://www.funny-emoticons.com/files/smileys-emoticons/funny-emoticons/51-too-hot.png"
        , source = "https://www.geo.fr/environnement/climat-la-temperature-a-lechelle-mondiale-a-augmente-de-12c-depuis-lepoque-preindustrielle-207876"
        }
        , { description = "La hausse des températures induit une perturbation du cycle de l'eau : plus de sécheresses, mais aussi plus de pluies torrentielles"
        , imageUrl = "https://aquaterrex.com/wp-content/uploads/2023/02/drought-and-rain-5-secs-1024x536.gif"
        , source = "https://www.huffingtonpost.fr/science/article/le-cycle-de-l-eau-est-en-train-de-changer-et-c-est-inquietant_195642.html#:~:text=%C3%80%20cause%20du%20r%C3%A9chauffement%20climatique,s%C3%A9cheresses%20et%20autres%20catastrophes%20naturelles.&text=jorgeciscar%20%2F%20500px%20via%20Getty%20Images,%C3%A0%20cause%20du%20r%C3%A9chauffement%20climatique."
        }
        , { description = "Un aller-retour en avion Paris New York émet 1.9 tonne de CO2"
        , imageUrl = "https://www.pngall.com/wp-content/uploads/2016/05/Plane-Download-PNG.png"
        , source = "https://co2.myclimate.org/fr/portfolios?calculation_id=6191028"
        }
        , { description = "Il y 20 000 ans, la température était 5°C en-dessous de celle de l'ère pré-industrielle et les mers étaient 120m plus hautes."
        , imageUrl = "https://www.youtube.com/watch?v=I3CsL15U-sM&t=1644s&ab_channel=Jean-MarcJancovici"
        , source = "https://cdn-icons-png.flaticon.com/256/4488/4488000.png"
        }
        , { description = "Pour respecter les accords de Paris et rester sous les 2°C de réchauffement, il faut que chaque personne émette 2 tonnes d'équivalent CO2 par an."
        , imageUrl = "https://www.liberateurdidees.com/web/image/product.template/4091/image_1024?unique=74a90e4"
        , source = "https://www.2tonnes.org/#:~:text=Pourquoi%202%20tonnes%20%3F&text=Afin%20de%20limiter%20les,ici%20la%20fin%20du%20si%C3%A8cle."
        }
        , { description = "On peut baisser nos émissions significativement en mangeant moins de viande"
        , imageUrl = "https://is3-ssl.mzstatic.com/image/thumb/Purple126/v4/ef/63/1d/ef631dfd-5741-0070-18a5-3f1ac1852041/source/256x256bb.jpg"
        , source = "https://www.trajectoires.media/f/impact-viande-climat"
        }
   ]

   ```

   Tentez de compiler sans changer d'autres chose.... Patatra, un sale erreur pas
   facile à comprendre. La principale difficulté ici est que l'erreur n'est pas
   indiqué à l'endroit le plus opportun.

9. On peut alors rajouter des **annotations de type** pour mieux indiquer au
   compilateur nos intentions et avoir des erreurs plus précises. En l'espèce,
   le soucis se situe au niveau de la fonction `viewCard`. Pour l'instant,
   cette fonction prend pour argument une chaîne de caractères (`String`) et renvoie du `Html`.

   On peut donc l'annoter ainsi (ignorez le `msg` pour l'instant):

   ```elm
   viewCard : String -> Html msg
   viewCard fact =
       ...
   ```

   Votre IDE devrait être content au niveau de cette fonction (mais toujours pas là où il râlait avant !).

10. Mais. Mais ce n'est pas ce qu'on veut! Maintenant
    nos "faits" ne sont plus de simples chaînes de caractères, mais des _record_.
    Changeons donc sa signature en:

    ```elm
    viewCard : { description : String, imageUrl: String, source : String } -> Html msg
    ```

    Cette fois-ci, le corps de la fonction n'est plus valide car `fact` est manipulé
    comme une `String` alors que c'est un _record_. Pour accéder en lecture au champ `description`, il suffit de faire `fact.description`.

    Corrigez donc cette fonction `viewCard` (rien ne doit changer pour l'instant à l'affichage).

11. Maintenant, il reste à afficher la carte complète. Modifiez donc le corps de la
    fonction `viewCard` pour que le rendu HTML soit le suivant:

    ```html
    <li
      class="w-96 p-3 rounded shadow border-l-4 border-solid border-blue-500 flex items-start space-x-4"
    >
      <div
        class="w-12 h-12 flex-shrink-0 rounded-full overflow-hidden shadow-lg"
      >
        <img
          src="https://image.com/monimage.jpg"
          class="w-full h-full object-cover"
        />
      </div>
      <div>
        <p class="font-bold">Bla bla bla description</p>
        <a
          href="https://source.fr/cestpasmoiquiledit.html"
          class="text-blue-500 text-sm underline"
          target="_blank"
        >
          source
        </a>
      </div>
    </li>
    ```

    (voir: https://jsfiddle.net/1vk28z7b/ pour un aperçu)

12. Aux points précédents, je vous ai grandement aidé en vous pointant sur quelle
    fonction il fallait ajouter l'annotation de type. Dans une vraie base de code
    bien sûr on ne pourra pas facilement deviner cela.

    En pratique donc, on annote _toutes_ les fonctions (ou quasiment toutes).
    Ainsi le compilateur comprend ce qu'on veut faire et peut nous pointer
    nos erreurs facilement. Donc aller hop, au boulot : annotez les définitions de
    `homeScreen`, `aboutMeScreen`, `layout`, `facts`, `thingsToKnowScreen` et
    `main`.

    Faites le dans l'ordre proposé et en recompilant à chaque fonction pour vérifier que tout va bien !

    _Un peu de typage de listes_

    En Elm, les listes sont **homogènes**, tous les éléments ont le même type. Par
    exemple : `["bla", "bli", "blo"]` est une liste de chaînes de caractères
    (`String`), qu'on note donc `List String`:

    ```elm
    mesMots : List String
    mesMots = ["bla", "bli", "blo"]
    ```

    Pareil, on pourrait avoir des listes d'entiers:

    ```elm
    mesNombres : List Int
    mesNombres = [42, 5, 42]
    ```

    Si les éléments de la liste sont de type `Html msg`, on parenthèse ainsi :
    `List (Html msg)`.

13. A priori, vous avez écrit deux fois le type
    `{ description : String, source : String }` pour `viewCard` et `facts`.

    Comme toute duplication, cela pose des soucis de synchronisation si par exemple
    on rajoute un champ : il faut penser à le rajouter aux deux endroits.

    On peut donc définir un "alias de type" (un synonyme) pour ne pas avoir à
    répéter cette définition :

    ```elm
    type alias Card =
        { description : String
        , imageUrl : String
        , source : String
        }
    ```

    Ajoutez ce type où cela vous paraît le plus pertinent dans le fichier (l'ordre
    des déclarations n'a pas d'importance en Elm), puis changer les annotations
    de type de `viewCard` et `facts` pour utiliser `Card`.

Bravo ! Nous avons vu comment utiliser les fonctions et des types en Elm pour
structurer une interface graphique. Dans la partie suivante, nous rajouterons
de l'interactivité !
