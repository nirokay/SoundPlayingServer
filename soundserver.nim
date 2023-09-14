## Sound Server
## ============
##
## Server binary, that will host the web-page and respond to user requests.

import std/[os, asyncdispatch, asynchttpserver, strutils, strformat]
import frontend/website, sounds/sounds

const
    port* {.intdefine.}: int = 42069
    htmlPathPrefix*: string = "."
    playingPath*: string = htmlPathPrefix & "/play/"

var server*: AsyncHttpServer = newAsyncHttpServer()


# -----------------------------------------------------------------------------
# Request Types
# -----------------------------------------------------------------------------

type RequestType* = enum
    HtmlPage, PlaySound

proc getRequestType(url: string): RequestType =
    if url.startsWith(playingPath): return PlaySound
    else: return HtmlPage


proc displayHtmlPage(path: string, request: Request) {.async.} =
    ## Interprets server request as displaying html site.
    let headers = newHttpHeaders([("Content-Type", "text/html")])
    var path: string =
        if request.url.path == "/": htmlPathPrefix & "/index.html"
        else: htmlPathPrefix & request.url.path
    if not path.endsWith(".html"): path &= ".html"

    var responseHtml: string =
        if fileExists(path) and path.split('.')[^1] == "html": readFile(path)
        else: "<html><body><h1>404: Not Found</h1><p>The path you are trying to access does not exist or is blocked.</p></body></html>"

    return request.respond(Http200, responseHtml, headers)

proc playSound(path: string, request: Request) {.async, gcsafe.} =
    ## Interprets server request as playing sound.
    let soundFile: string = block:
        var x: string = path
        x.removePrefix(playingPath)
        x
    let headers = newHttpHeaders([("Content-Type", "text/html")])
    if not fileExists(soundDirectory & soundFile):
        return request.respond(Http404, SoundFailure.getResponseAfterSound(soundFile), headers)

    playFile(soundFile)
    return request.respond(Http200, SoundSuccess.getResponseAfterSound(soundFile), headers)


# -----------------------------------------------------------------------------
# Server
# -----------------------------------------------------------------------------

proc processRequest(request: Request) {.async, gcsafe.} =
    # Request path (if empty, redirect to index.html):
    var path: string =
        if request.url.path == "/": htmlPathPrefix & "/index.html"
        else: htmlPathPrefix & request.url.path

    case path.getRequestType():
    of HtmlPage:
        await path.displayHtmlPage(request)
    of PlaySound:
        await path.playSound(request)

proc runServer*() {.async.} =
    server.listen(Port port)
    echo &"Server is listening on port {port}!"

    while true:
        if server.shouldAcceptRequest():
            await server.acceptRequest(processRequest)
        else:
            echo "Refused request"
            await sleepAsync(500)


# Generate html site(s) and run server:
generateHtmlIndex()

when isMainModule: waitFor runServer()
