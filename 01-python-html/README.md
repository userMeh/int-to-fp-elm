# Écrire un DSL en quelques lignes - ou l'art du copié-collé

## Utiliser une solution en ligne

Vous pouvez utiliser Glitch en "remixant" le projet suivant :
https://glitch.com/edit/#!/intro-to-fp-01

Cette solution a l'avantage de n'avoir rien besoin d'installer et de partager
facilement son travail.

En revanche, l'édition peut souffrir d'une certaine lenteur par rapport à
un éditeur local.

Vous devrez recharger la page sur l'aperçu à droite (ou en ouvrant un aperçu
dans une autre fenêtre) pour voir changements.

## Lancer le projet localement

Alternativement vous pouvez utiliser faire tourner le projet sur
votre ordinateur. Il faut avoir Python et pip installé.

Installer les dépendances (juste flask!):

```
pip3 install -r requirements.txt
```

Lancer le serveur :

```
python3 src/server.py
```

(inutile de relancer le serveur à chaque modification, le serveur flask de
développement prend très bien ça en charge!)

Voir le (super!) site: http://localhost:5000 (il faut par contre recharger la page à chaque modification).

## Exercices

1. Se rendre sur le site et ouvrir l'inspecteur de code (F12 sur la plupart des
   navigateurs). Faire la correspondance entre le HTML affiché dans le navigateur
   et le code Python dans `src/server.py`.
2. Jetez un coup d'oeil au fichier `src/simpleHtml.py`. Admirez-en la simplicité\*.
   Ce module n'utilise que des fonctions !
3. Maintenant on va ajouter du contenu dans la page `/about-me` qui est déjà créée.
   Pour l'instant on s'embête pas, copiez-collez le corps de la fonction `home` et
   changez les phrases `Welcome to the site's content` et
   `This is where your content goes` par quelques données sur vous (genre "Je
   m'appelle Archibald, j'ai 12 ans" ou "je suis ingénieur informaticien, j'aimeuh
   les ordinateurs... windows 95 !"). Ah oui ! et vu qu'on fait les choses bien, on
   va changer la balise `title` de `My Website` en `Moi d'abord !`.

   Bien sûr vérifiez que ça marche : http://localhost:5000/about-me.

4. Hum hum, le code commence à devenir touffu! Regardons bien ce qui change entre ces 2
   fonctions: le `title` et le contenu des pages. À défaut d'avoir un contenu
   intéressant, organisons notre code de façon potable : créez une fonction
   `layout(title, content)` pour que la fonction `home` ressemble à (là encore, vous êtes encouragés à utiliser les touches "ctrl" "c" et "v" de votre clavier\*\*) :

   ```python
   @app.route("/")
   def home():
       return layout(
           "My website",
           [
               H.p(
                   {},
                   ["Welcome to the site's content."],
               ),
               H.p(
                   {},
                   ["This is where your content goes."],
               ),
           ],
       )
   ```

   Bien sûr faites un truc similaire pour `about_me` en utilisant la même
   fonction `layout`.

5. Rajoutez une nouvelle route `/things-to-know` utilisant la fonction `layout`
   définie précédemment. Choisissez un `title` qui vous plaît et pour le contenu, on
   se contentra d'une liste vide. Vérifiez que ça marche : http://localhost:5000/things-to-know
6. Voici une liste de faits:

   ```python
   facts = [
        "En 2023, la température de la terre a augmenté de 1.2°C par rapport à l'ère pré-industrielle",
        "La hausse des températures induit une perturbation du cycle de l'eau : plus de sécheresses, mais aussi plus de pluies torrentielles",
        "Un aller-retour en avion Paris New émet 1.75 tonne de CO2",
        "Il y 20 000 ans, la température était 5°C en-dessous de celle de l'ère pré-industrielle et les mers étaient 120m plus hautes.",
        "Pour respecter les accords de Paris et rester sous les 2°C de réchauffement, il faut que chaque personne émette 2 tonnes d'équivalent CO2 par an.",
        "L'empreinte carbonne annuelle d'un Français est de 9 tonnes d'équivalent CO2",
        "On peut baisser nos émissions significativement en mangeant moins de viande"

   ]
   ```

   Copiez-collez cette liste dans votre code.

7. Affichez la liste précédente à l'aide de balises `ul` et `li`. Le HTML généré doit ressembler à:

   ```html
   <ul>
     <li>En 2023, ...</li>
     <li>La hausse ...</li>
   </ul>
   ```

   On utilisera une compréhension de liste pour construire les enfants du noeud `ul` :

   ```python
   H.ul(
    {},
    [ replace_with_the_li_node_here for fact in facts ]
   )
   ```

   Si vous ne connaissez pas les compréhensions de liste, furetez par là : https://gayerie.dev/docs/python/python3/list_comprehension.html

8. C'est pas super jojo tout ça, on créer une jolie petite carte pour chacun des
   faits. Par exemple en appliquant les classes suivantes, ça rend tout suite mieux:
   ```html
   <ul class="flex flex-col space-y-8">
     <li class="p-3 rounded shadow border-l-4 border-solid border-blue-500">
       En 2023, ...
     </li>
     <li class="p-3 rounded shadow border-l-4 border-solid border-blue-500">
       La hausse ...
     </li>
   </ul>
   ```
   Modifiez votre code python pour intégrer ces classes.
9. La création de la "carte" devient un peu complexe et on en aura probablement
   besoin pour à d'autres endroits. Créez donc un "composant", i.e. une fonction
   `view_card(text)` qui permette de ré-factorer le code en:
   ```python
   H.ul(
    {},
    [ view_card(fact) for fact in facts ]
   )
   ```
10. On a donc appliqué une fonction à chacun des éléments d'une liste. C'et une
    opération assez courante en programmation fonctionnelle, on peut donc écrire
    plus simplement la compréhension de liste précédente\*\*\*:
    ```python
    H.ul(
        {},
        map(view_card, facts)
    )
    ```

Bravo ! Vous pouvez maintenant passer au fichier TRANSITION_TO_ELM.md.

\* Vous avez intérêt à admirer cette simplicité, c'est moi qui note !

\*\* "Ouiiiin j'ai pas de touche `ctrl` moi !"... Ne me dites pas que vous êtes sur Mac, ça va mal se passer...

\*\*\* 2 choses à noter sur `map` en Python :

- en Python on préférera sûrement utiliser une compréhension de liste (ou une
  expression génératrice) plutôt que `map`, on prépare ici le terrain pour Elm !
- `map` en Python ne crée pas une liste mais un itérateur qui est une bestiole assez
  différente (dans notre cas on peut "faire comme si c'était une liste"). Prudence
  donc en utilisant cette fonction !
