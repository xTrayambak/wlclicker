import std/[os, osproc, logging]
import netty, colored_logger

proc main {.inline.} =
  addHandler newColoredLogger()

  if paramCount() < 1:
    quit "Expected command [daemon/lmb/rmb]"

  case paramStr(1)
  of "daemon":
    if not isAdmin():
      error "Expected root privileges"
      quit(1)

    let reactor = newReactor("127.0.0.1", 9899)
    info "Daemon is now running at port 9899"
    
    while true:
      reactor.tick()
      for message in reactor.messages:
        case message.data
        of "lmb":
          reactor.send(message.conn, "ok")
          discard execCmd("ydotool click 0xC0")
        of "rmb":
          reactor.send(message.conn, "ok")
          discard execCmd("ydotool click 0xC1")
        else:
          error "Invalid request: " & message.data
          reactor.send(message.conn, "invalid request")
  else:
    let reactor = newReactor()
    let conn = reactor.connect("127.0.0.1", 9899)

    reactor.tick()
    reactor.send(conn, paramStr(1))
    reactor.tick()

    for msg in reactor.messages:
      echo msg.data

when isMainModule: main()
