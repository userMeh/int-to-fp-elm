from flask import Flask
import simpleHtml as H

app = Flask(__name__)


def layout(title, content):
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
                        H.title({}, [title]),
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
                        H.div(
                            {"class": "w-1/4 h-screen bg-gray-200"},
                            [
                                H.div(
                                    {"class": "p-4"},
                                    [
                                        H.span(
                                            {"class": "text-lg font-bold"},
                                            ["Menu"],
                                        ),
                                        H.p({}, ["Item 1"]),
                                        H.p({}, ["Item 2"]),
                                        H.p({}, ["Item 3"]),
                                    ],
                                )
                            ],
                        ),
                        H.div(
                            {"class": "w-3/4"},
                            [
                                H.div(
                                    {"class": "bg-blue-500 p-4"},
                                    [
                                        H.span(
                                            {"class": "text-3xl text-white"},
                                            ["Site Title"],
                                        )
                                    ],
                                ),
                                H.div({"class": "p-4"}, content),
                            ],
                        ),
                    ],
                ),
            ],
        ),
    )


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


@app.route("/about-me")
def about_me():
    return layout(
        "Moi d'abord !",
        [
            H.p(
                {},
                ["Coucou c'est Sébastien."],
            ),
            H.p(
                {},
                ["J'aime la tartiflette."],
            ),
        ],
    )


facts = [
    "En 2023, la température de la terre a augmenté de 1.2°C par rapport à l'ère pré-industrielle",
    "La hausse des températures induit une perturbation du cycle de l'eau : plus de sécheresses, mais aussi plus de pluies torrentielles",
    "La trajectoire des émissions de CO2 actuelle nous amène vers +3 ou 4°C par rapport l'ère pré-industrielle.",
    "Un aller-retour en avion Paris New émet 1.75 tonne de CO2",
    "Il y 20 000 ans, la température était 5°C en-dessous de celle de l'ère pré-industrielle et les mers étaient 120m plus hautes.",
    "Pour respecter les accords de Paris et rester sous les 2°C de réchauffement, il faut que chaque personne émette 2 tonnes d'équivalent CO2 par an.",
]


@app.route("/things-to-know")
def things_to_know():
    return layout(
        "À savoir",
        [
            H.ul(
                {"class": "flex flex-col space-y-8"},
                [view_card(fact) for fact in facts],
            )
        ],
    )


def view_card(text):
    return H.li(
        {"class": "p-3 rounded shadow border-l-4 border-solid border-blue-500"}, text
    )


if __name__ == "__main__":
    app.run(debug=True)
