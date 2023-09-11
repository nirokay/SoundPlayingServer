# Package

version       = "0.1.0"
author        = "nirokay"
description   = "A server with an html frontend to play sounds over the network."
license       = "GPL-3.0-only"
bin           = @["soundserver"]


# Build Frontend html

include "frontend/website.nims"


# Dependencies

requires "nim >= 2.0.0"
requires "websitegenerator"
