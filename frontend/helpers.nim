## Collection of helper procedures regarding the frontend

import websitegenerator

proc embedStyle*(html: var HtmlDocument, css: CssStyleSheet) =
    ## Embeds css into html body
    html.addToHead(newElement("style", $css))

proc newHtmlDocument*(file: string): HtmlDocument =
    ## Makes it, so you can actually read the text on mobile devices
    result = newDocument(file)
    result.addToHead(
        charset("utf-8"),
        viewport("width=device-width, initial-scale=1")
    )
