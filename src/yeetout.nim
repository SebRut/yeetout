import std/sequtils
import yeetout/json
import yeetout/private/yeetbase

export yeetbase
export JsonYeeter

var yeetOutput*: File = stdout
var yeeter*: Yeeter = JsonYeeter()

proc yeet*(message: string, arguments: openArray[Argument] = [], level: YeetLevel = yLvlInfo): void =
  let yeet: Yeet = (level: level, message: message, arguments: arguments.toSeq)
  
  yeeter.yeet(yeet, yeetOutput)

proc debugYeet*(yeeter: Yeeter, message: string, arguments: openArray[Argument] = []): void =
  yeet(message, arguments, yLvlDebug)