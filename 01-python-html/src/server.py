from flask import Flask
import simpleHtml as H

app = Flask(__name__)


@app.route("/")
def home():
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
                        H.title({}, ["My Website"]),
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
                                H.div(
                                    {"class": "p-4"},
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
                                ),
                            ],
                        ),
                    ],
                ),
            ],
        ),
    )


@app.route("/about-me")
def about_me():
    return "TODO !"


if __name__ == "__main__":
    app.run(debug=True)
