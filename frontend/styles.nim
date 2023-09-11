import websitegenerator

var cssTemplate*: CssStyleSheet = newCssStyleSheet("styles.css")

const
    textCenter = ["text-align", "center"]
    textUnderline = ["text-decoration", "underline"]
    textNoDecoration = ["text-decoration", "none"]
    textTransparentBackground = ["background-color", "transparent"]

proc elem(name: string, attributes: varargs[array[2, string]]): CssElement =
    newCssElement(name, attributes)

proc link(which: string, colour: string|CssColour): CssElement =
    elem("a:" & which,
        ["color", $colour],
        textNoDecoration,
        textTransparentBackground
    )

# Random trickery to let the compiler use css in gcsafe rooms
proc getCss(): CssStyleSheet =
    result = newCssStyleSheet("styles.css")
    result.add(
        elem("body",
            fontFamily("Verdana, Geneva, Tahoma, sans-serif"),
            colour(White),
            backgroundColour(rgb(23, 25, 33))
        ),

        elem("h1", textCenter, textUnderline),
        elem("h2", textUnderline),
        elem("h3", textUnderline),

        link("link", Pink),
        link("visited", Hotpink),
        link("hover", Deeppink),
        link("active", Darkmagenta)
    )

const css* = getCss()
