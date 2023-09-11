import websitegenerator

proc embedStyle*(html: var HtmlDocument, css: CssStyleSheet) =
    html.addToHead(newElement("style", $css))

proc newHtmlDocument*(file: string): HtmlDocument =
    result = newDocument(file)
    result.addToHead(
        charset("utf-8"),
        viewport("width=device-width, initial-scale=1")
    )
