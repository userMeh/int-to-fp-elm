# WARNING! This library is written for pedagogical purposes,
# DO NOT USE IN PRODUCTION!
#
# Actually, this lib is really sensible to injection attacks.
# We could easily fix most of those issues by adding some checks but we want to
# stay as simple as possible.


def _render_attributes(attributes):
    if not attributes:
        return ""
    return " ".join([f'{key}="{value}"' for key, value in attributes.items()])


def node(tag, attributes, children):
    attributes_str = _render_attributes(attributes)
    children_str = "".join(children)
    return f"<{tag} {attributes_str}>{children_str}</{tag}>"


def div(attributes, children):
    return node("div", attributes, children)


def p(attributes, children):
    return node("p", attributes, children)


def ul(attributes, children):
    return node("ul", attributes, children)


def li(attributes, children):
    return node("li", attributes, children)


def span(attributes, children):
    return node("span", attributes, children)


def html(attributes, children):
    return node("html", attributes, children)


def head(attributes, children):
    return node("head", attributes, children)


def body(attributes, children):
    return node("body", attributes, children)


def title(attributes, children):
    return node("title", attributes, children)


def self_closing(tag, attributes):
    attributes_str = _render_attributes(attributes)
    return f"<{tag} {attributes_str} />"


def meta(attributes):
    return self_closing("meta", attributes)


def link(attributes):
    return self_closing("link", attributes)


def doc_type(tag, child):
    return f"<!DOCTYPE {tag}>{child}"
