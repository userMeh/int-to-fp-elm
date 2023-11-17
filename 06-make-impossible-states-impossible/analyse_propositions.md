```elm
-- NumberInput entre 1 et 13 (11 = Valet, 12 = Dame et 13 = Roi)

type Card = { number : Int, typeCard : String, isJoker : Boolean }
```

Nombre de valeurs possibles : infini _ infini _ 2 = infini !

et après le Joker c'est une checkbox si c'est activé, je desactive les champs de saisie
sinon je prends en compte les champs de saisie

```elm
card : Card
card = { number = 42, typeCard = "machin", isJoker = False }
```

--> Bof, on peut produire plein de carte invalide.

```elm
type Suit = Heart
        | Diamond
        | Spade
        | Club

type Num = Number Int
        | Jack
        | Queen
        | King

type Card = NormalCard Suit Num
        | Joker


-- Example
tmpCard : Card
tmpCard = NormalCard Heart (Number 7)

```

nombre de valeurs possibles :

- 4 pour Suit
- infini (pour Int) + 3 = infini pour Num
- 4 (suit) \* infini (Num) + 1 (Joker) = Infini

--> Mieux mais on peut mettre `14` dans le nombre.

```elm
type alias Card = {value : Value, color : Color, joker : Bool}
type Color = Heart | Diamond | Spike | Club
type Value = V1 | V2 | V3 | V4 | V5 | V6 | V7 | V8 | V9 | V10 | Jacket | Queen | King
-- inutile, le type Bool existe déjà.
type Bool = True | False
```

nombre de cartes:

- value : 13
- couleur : 4
- joker : 2
  Total : 13 _ 4 _ 2 = 104

--> Que fait-on de :

```elm
card = {value = V10, color = Heart, joker=True }
```

```elm
type alias Card = {value : Value, color : Color}
type Color = Heart | Diamond | Spike | Club
type Value = V1 | V2 | V3 | V4 | V5 | V6 | V7 | V8 | V9 | V10 | Jacket | Queen | King | Joker
```

--> Que fait-on de:

```elm
card = {value = Joker, color = Heart }
```

???

Modèle béton :

```elm
type Value = V1 | V2 | V3 | V4 | V5 | V6 | V7 | V8 | V9 | V10 | Jacket | Queen | King
type Suit = Heart | Diamond | Spike | Club
type Card = NormalCard Value Suit | Joker

-- example:
card : Card
card = NormalCard V1 Heart
```

nombre de cartes:

- value : 13
- couleur : 4
- card = 13 \* 4 + 1 (Joker) = 53

alternative équivalente:

```elm
type Value = V1 | V2 | V3 | V4 | V5 | V6 | V7 | V8 | V9 | V10 | Jacket | Queen | King
type Suit = Heart | Diamond | Spike | Club
type Card = NormalCard {value:Value,  suit: Suit} | Joker

-- example:
card : Card
card = NormalCard {value=V1, suit = Heart}
```
