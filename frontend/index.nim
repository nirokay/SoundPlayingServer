## Index
## =====
##
## Main html page with all sound links.

import std/[strutils]
from unicode import capitalize
import websitegenerator
import ./styles, ./helpers, ../sounds/sounds

var html*: HtmlDocument = newHtmlDocument("index.html") ## Index html document

html.embedStyle(css)

html.addToHead(
    title("Silly"),
    description("Pretty silly.")
)

html.addToBody(
    h1("Silly soundboard/sound player"),
    p("With this tool you are able to remotely make my computer play sounds."),
    p("This has been a horrible idea...")
)

proc nameShowcase*(file: string): string =
    result = file.split('.')[0..^2].join(" ")
    result = result.replace('_', ' ')
    result = result.replace('-', ' ')

    var
        raw: seq[string] = result.split(' ')
        cap: seq[string]

    for word in raw:
        cap.add(word.capitalize())

    result = cap.join(" ")

proc newButton(file: string): HtmlElement =
    p($a("/play/" & file, file.nameShowcase()))

for i in soundList:
    html.addToBody(newButton(i))
