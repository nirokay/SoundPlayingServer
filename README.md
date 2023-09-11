# SoundPlayingServer

## About

This is a silly project. It allows you to play sounds over the (local) network using HTTP.

## Hosting

Compile the server executable with `nimble build` and run it `./soundserver`. By default the webserver uses port `42069`, but this can be changed with the `-d:port:[integer]` compile-time switch (-> `nimble build -d:port:80` for port 80).

To access the web-interface, open your browser and navitage to `localhost:[port number]` (default: `localhost:42069`).

If you want other devices in your local network to access the interface, allow incoming requests on the port used by the program. After that connect to the webpage with the local IP of the host.

## Dependancies

Compiling:

* [Nim toolchain](https://nim-lang.org/)

* Nim libraries:
  * [websitegenerator](https://github.com/nirokay/websitegenerator) (will be automatically installed through nimble)

Runtime:

* [bash](https://www.gnu.org/software/bash/) (other, similar shells should work as well)
* any media player (default: [vlc](https://www.videolan.org/vlc/))
