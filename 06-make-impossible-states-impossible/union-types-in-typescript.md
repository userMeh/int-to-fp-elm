# Les types unions en Typescript

Typescript est un sur-ensemble de Javascript: n'importe quel
code écrit en Javascript est du Typescript valide (en théorie...).

De façon générale, dans à peu près tous les systèmes de typages,
un "type" représente un ensemble de valeurs possibles.

Par exemple `number` en typescript est l'ensemble de tous les
nombres flottant(`0`, `549.322141`, `-48`,...). Le type `string`
en typescript ou `String` en Elm celui de toutes les chaînes de caractère.

## Unions discriminées ou non

Pour ces types "basiques", les notions coïncident bien. On a par contre
une vraie différence quand on commence à faire des "unions" (une valeur
est soit d'un type A, soit d'un type B).

En Elm, on peut uniquement décrire des "unions discriminées". Par exemple
on peut créer :

```elm
type IntOrString = ThisIsAnInt Int | ThisIsAString String
```

On a ici complètement créé de nouvelles valeurs avec les "wrappers" `ThisIsAnInt` et
`ThisIsAString`. Une valeur de type `IntOrString` est alors soit de la forme
`ThisIsAnInt 42` soit `ThisIsAString "hello"`.
En particulier, la valeur "toute nue" 42 n'est pas de type `IntOrString`, ni `"hello"`.

En Typescript, on a des "unions non discriminées". On peut donc créer le type (il n'y a pas
de type "entier" en javascript/typescript, juste des "nombres") :

```ts
type NumberOrString = number | string;
```

On remarque ici qu'il n'y a pas de "wrapper", `42` et `"hello"` sont tous deux de
type `NumberOrString`.

## Une situation où on doit discriminer !

Considérons une API HTTP d'un logiciel de gestion RH renvoyant le salaire d'un employé.

Vu qu'on effectue un appel réseau, il peut y avoir une erreur (réseau coupé, serveur planté,
base de donnée dans les choux.... choisissez !). On peut donc typer le résultat
comme (en Typescript):

```typescript
type ApiResponse = string | number;
```

- le `string` représente un cas d'erreur, la string contenant un message explicitant l'erreur.
- le `number` représente le salaire de l'employé qu'on a demandé.

Oui mais ! Mais :

- il est assez dur de savoir ce à quoi correspondent cette `string` et ce `number` sans ajouter
  des commentaires qui peuvent facilement se désynchroniser avec le code.
- en fait il y a un troisième cas ! Dans le cas où l'employé a quitté l'entreprise, on renvoie
  le nombre de jours depuis qu'il a quitté son poste. Comment alors faire la distinction entre un `number` qui est un salaire et un `number` qui est un nombre d'années ?

Voyons comment on ferait en Elm:

```elm
type ApiResponse
    = Error String
    | Salary Float
    | EmployeeLeft Int
```

Et voilà ! Les cas sont explicitement décrits dans le code et il est facile de
rajouter d'autres cas.

## Simuler des unions discriminées en Typescript

On peut bien sûr singer ces unions en Typescript en utilisant un champ d'un objet
faisant office de discriminant. Ici nous choisissons `kind`, on peut choisir ce qu'on veut bien
sûr (`tag` par exemple est aussi très utilisé pour cet usage):

```ts
type ApiResponse =
  | { kind: "Error"; errorMessage: string }
  | { kind: "Salary"; amount: number }
  | { kind: "EmployeeLeft"; days: number };
```

## Avantages de chaque type d'union

Les unions non discriminées sont plus expressives que leur pendant
discriminées : on peut décrire plus de types grâce aux unions non discriminées
(comme on l'a vu on peut simuler les unions discriminées dans un système d'unions
"libres").

En revanche, les unions discriminées permettent d'avoir des messages d'erreurs
plus précis et pertinents. Les algorithmes de vérification de types sont également
plus simples et rapides, influant sur le temps de compilation des projets.
