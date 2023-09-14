## Frontend builder
## ================
##
## This module builds the html documents used for the front end.

import std/[strformat]
import websitegenerator
import ./index, ./styles, ./helpers
export html

# Write index.html to disk:
proc generateHtmlIndex*() =
    ## Writes the html file to disk
    html.writeFile()

# Dynamic html for success/failure:
type SoundPlayingState* = enum
    SoundSuccess, SoundFailure

proc getResponseAfterSound*(state: SoundPlayingState, file: string): string {.gcsafe.} =
    ## Returns html string.
    ##
    ## Used for responses after playing a sound. These are generated at run-time.
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
