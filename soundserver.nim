import std/[asyncdispatch, asynchttpserver]

const
    port*: int = 42069

var server: AsyncHttpServer = newAsyncHttpServer()

proc processRequest(request: Request) {.async.} =
    request.respond(Http200, "Played sound.")

discard server.serve(Port(port), processRequest)
