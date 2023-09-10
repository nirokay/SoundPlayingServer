import std/[os, strutils, strformat]
from unicode import toLower

const mediaplayer*: string = "./mediaplayer.sh"

const
    soundDirectory*: string = "./sounds/"
    soundFileExtentions*: seq[string] = @[
        "wav", "aif", "mp3", "mid", "aac", "flac", "wma"
    ]

var soundList*: seq[string]
for kind, path in walkDir(soundDirectory):
    if kind notin [pcFile, pcLinkToFile]: continue
    if path.toLower().split('.')[^1] notin soundFileExtentions: continue
    soundList.add(path.replace('\\', '/').split('/')[^1])

proc playFile*(filename: string) =
    let file: string = soundDirectory & filename
    discard execShellCmd(quoteShell(
        &"{mediaplayer} {file}"
    ))
