## Sound stuff
## ===========
##
## [insert self-explanatory description]

import std/[os, strutils, strformat]
from unicode import toLower

const
    mediaplayer*: string = "./mediaplayer.sh" ## Media player (redirects to custom script)
    soundDirectory*: string = "./sounds/"
    soundFileExtentions*: seq[string] = @[
        "wav", "aif", "mp3", "mid", "aac", "flac", "wma"
    ] ## List of all valid file extentions/audio formats

var soundList*: seq[string] ## List of all valid files
for kind, path in walkDir(soundDirectory):
    if kind notin [pcFile, pcLinkToFile]: continue
    if path.toLower().split('.')[^1] notin soundFileExtentions: continue
    soundList.add(path.replace('\\', '/').split('/')[^1])

proc playFile*(filename: string) =
    ## Plays the audio file through the shell
    let file: string = soundDirectory & filename
    discard execShellCmd(
        &"{mediaplayer} {file}"
    )

