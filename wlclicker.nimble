# Package

version       = "0.1.0"
author        = "xTrayambak"
description   = "Userspace interface for ydotool"
license       = "GPL-3.0-or-later"
srcDir        = "src"
bin           = @["wlclicker"]


# Dependencies

requires "nim >= 2.0.0"

requires "netty >= 0.2.1"
requires "jsony >= 1.1.5"
requires "colored_logger >= 0.1.0"