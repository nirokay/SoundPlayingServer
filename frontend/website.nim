## Frontend builder

import std/[strformat]
import websitegenerator
import ./index, ./styles, ./helpers

# Write to disk:
html.writeFile()

# Dynamic html for success/failure:
type SoundPlayingState* = enum
    SoundSuccess, SoundFailure

proc getResponseAfterSound*(state: SoundPlayingState, file: string): string {.gcsafe.} =
    ## Returns html string
    var
        html: HtmlDocument = newHtmlDocument("soundsuccess.html")
        headerText: string
        description: string

    case state:
    of SoundSuccess:
        headerText = "Successfully played sound!"
        description = &"Sound played: {$b file.nameShowcase()}"
    of SoundFailure:
        headerText = "Failed to play sound!"
        description = &"The file {$b file} does not exist. Could not play {$b file.nameShowcase()}"

    html.addToBody(
        a("/", $b("< Back to main page")),
        h1(headerText),
        p(description)
    )

    html.embedStyle(css)

    result = $html
