Reprenons ce bout de code :

```python
def layout(content):
    return H.doc_type(
        "html",
        H.html(
            {"lang": "en"},
            [
                H.head(
                    {},
                    [
                        H.meta({"charset": "UTF-8"}),
                        H.meta(
                            {
                                "name": "viewport",
                                "content": "width=device-width, initial-scale=1.0",
                            }
                        ),
                        H.title({}, ["My web site!"]),
                        H.link(
                            {
                                "href": "https://cdn.jsdelivr.net/npm/tailwindcss@2.2.15/dist/tailwind.min.css",
                                "rel": "stylesheet",
                            }
                        ),
                    ],
                ),
                H.body(
                    {"class": "flex"},
                    [
                        ...
                    ]
                )
            ]
        )
    )
```

On pourrait être tenté d'extraire le header dans une variable pour le réutiliser
et/ou avoir un code plus lisible:

```python
head = H.head(
    {},
    [
        H.meta({"charset": "UTF-8"}),
        H.meta(
            {
                "name": "viewport",
                "content": "width=device-width, initial-scale=1.0",
            }
        ),
        H.title({}, ["My web site!"]),
        H.link(
            {
                "href": "https://cdn.jsdelivr.net/npm/tailwindcss@2.2.15/dist/tailwind.min.css",
                "rel": "stylesheet",
            }
        ),
    ],
)

def layout(content):
    return H.doc_type(
        "html",
        H.html(
            {"lang": "en"},
            [
                head,
                H.body(
                    {"class": "flex"},
                    [
                        ...
                    ]
                )
            ]
        )
    )
```

Alright, so far, so good. Mais. Mais on se rend compte _après coup_ qu'il faut
pouvoir paramétrer le titre : ce peut être "My website!", ou "Moi d'abord !".
Notre approche ne marche donc pas :/.
"Ah, _facile_!", me direz-vous, "il _suffit_ de transformer cette variable `head` en une fonction prenant le titre en paramètre"

Allons-y:

```python
def head(title):
    return H.head(
        {},
        [
            H.meta({"charset": "UTF-8"}),
            H.meta(
                {
                    "name": "viewport",
                    "content": "width=device-width, initial-scale=1.0",
                }
            ),
            H.title({}, [title]),
            H.link(
                {
                    "href": "https://cdn.jsdelivr.net/npm/tailwindcss@2.2.15/dist/tailwind.min.css",
                    "rel": "stylesheet",
                }
            ),
        ],
    )
```

Mais... la transformation est loin d'être _facile_ et rajoute/modifie pas mal de
symboles :

- `def` est ajouté,
- le `=` devient `:`,
- le paramètre `title` est ajouté,
- les parenthèses sont ajoutés autour de l'argument `title`,
- en suivant la même convention de formatage du code, tout le corps de la fonction,
  est indenté d'un niveau supplémentaire (bonjour le diff dans git!),
- ajout du mot clef `return`.

Et si on y réfléchit 5 minutes, seul un ajout ici est fondamental. Voyez-vous lequel?

Reprenons et essayons d'ajouter le seul truc "essentiel" : ajouter un paramètre !
(ceci n'est pas du Python -- ce n'est pas du Elm non plus, c'est pour l'instant du gloubiboulga) :

```python
head title = H.head(
    {},
    [
        H.meta({"charset": "UTF-8"}),
        H.meta(
            {
                "name": "viewport",
                "content": "width=device-width, initial-scale=1.0",
            }
        ),
        H.title({}, [title]),
        H.link(
            {
                "href": "https://cdn.jsdelivr.net/npm/tailwindcss@2.2.15/dist/tailwind.min.css",
                "rel": "stylesheet",
            }
        ),
    ],
)
```

Oui, j'ai juste inséré `<espace>title` entre `head` et `=`. Pourquoi se compliquer la vie ? Plutôt élégant non\* ? On a éliminé tous les bullet points de la liste précédente sauf l'ajout du paramètre.

Mais ne nous arrêtons pas en si bon chemin ! Si on peut _définir_ une fonction en séparant les arguments juste par des espaces, pourquoi ne pourrait-on pas le faire pour _appeler_ une fonction ?

Je m'explique. Vous êtes sûrement habitué à appeler les fonctions de cette façon:

```python
super_function(42, 56)
```

Eh bien comme précédemment, séparons les arguments juste avec des espaces :

```elm
super_function 42 56
```

(si vous regardez bien, ce dernier bout de code est 2 caractères plus court que le précédent... en plus d'avoir beaucoup moins de "bruit" visuel).

Réécrivons donc notre fonction `head` dans ce style:

```elm
head title = H.head
    {}
    [
        H.meta {"charset": "UTF-8"},
        H.meta
            {
                "name": "viewport",
                "content": "width=device-width, initial-scale=1.0",
            },
        H.title {} [title],
        H.link
            {
                "href": "https://cdn.jsdelivr.net/npm/tailwindcss@2.2.15/dist/tailwind.min.css",
                "rel": "stylesheet",
            },
    ]
```

(ce n'est toujours pas du elm mais c'est très proche!)

Vous avez maintenant l'idée de la syntaxe Elm : les arguments de fonctions sont
juste séparés par des espaces au lieu de rajouter des parenthèses et des virgules.
Vous comprendrez plus tard que cela a une conséquence très intéressante concernant
la curryfication des fonctions (aucun rapport avec la cuisine indienne).

Pour finir, histoire que vous ne soyez pas surpris : en Elm on préfère formater
les listes en mettant la virgule en début de ligne ([quelques arguments en faveur de ce style](https://dev.to/tao/the-case-for-comma-leading-lists-3n49)):

```elm
head title = H.head
    {}
    [ H.meta { "charset": "UTF-8" }
    , H.meta
        { "name": "viewport"
        , "content": "width=device-width, initial-scale=1.0"
        }
    , H.title {} [ title ]
    , H.link
        { "href": "https://cdn.jsdelivr.net/npm/tailwindcss@2.2.15/dist/tailwind.min.css"
        , "rel": "stylesheet"
        }
    ]
```

(ce n'est toujours pas _exactement_ du Elm)

### "Mais comment fait-on si veut passer des expression compliquées en paramètres ?"

Prenons un code Python qui appelle une fonction dans une autre fonction:

```python
# Python
f(g(x, y), z)
```

Si on écrit naïvement en Elm:

```elm
-- elm
f g x y z
```

On n'exprime pas la même chose : ici on dit "appliquer f aux arguments g, x, y et z".

Pour exprimer la même chose qu'en python, il faut écrire:

```elm
-- elm
f (g x y) z
```

Vous êtes fin prêt à attaquer la deuxième partie !

---

\* Encore une fois, c'est moi qui note, donc vous avez intérêt à trouver ça élégant !
