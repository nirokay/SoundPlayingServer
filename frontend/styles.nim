## CSS
## ===
##
## Make website look pwetty :3

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
    ## Hyperlinks
    elem("a:" & which,
        ["color", $colour],
        textNoDecoration,
        textTransparentBackground
    )

const
    centerClass*: CssElement = newCssClass("center",
        width("90%"),
        display("block"),
        textCenter
    )

    buttonClass*: CssElement = newCssClass("button",
        ["border", 0.px],
        backgroundColour("#9187CC"),
        colour(White),
        padding(8.px),
        textCenter,
        textNoDecoration,
        display(inlineGrid),
        ["transition-duration", "0.4s"],
        ["cursor", "pointer"]
    )

    buttonHoverClass*: CssElement = newCssClass(buttonClass.name[1 .. ^1] & ":hover",
        backgroundColour("#BD93F9"),
        ["border", 10.px],
        textUnderline,
        borderColour(rgb(255, 255, 255))
    )


proc getCss(): CssStyleSheet =
    ## This is horrible...
    ##
    ## It only exists to make the `css` variable `gcsafe`, as it is a constant.
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
        link("active", Darkmagenta),

        centerClass,

        buttonClass,
        buttonHoverClass
    )

const css* = getCss() ## Global css stylesheet
