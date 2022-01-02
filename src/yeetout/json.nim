import yeetout/private/yeetbase
import std/json
import std/jsonutils

type
    JsonYeeter* = ref object of Yeeter

proc toJsonHook*(level: YeetLevel): JsonNode =
  toJson($level)
proc toJsonHook*(argVal: ArgumentValue): JsonNode =
  case argVal.kind
  of avkString: toJson(argVal.stringVal)
  of avkSeq: toJson(argVal.seqVal)

proc toJsonHook*(yeet: Yeet): JsonNode =
  result = newJObject()
  result["level"] = toJson(yeet.level)
  result["message"] = toJson(yeet.message)

  for arg in yeet.arguments:
    result[arg[0]] = toJson(arg[1])

method yeet(this: JsonYeeter, yeet: Yeet, output: File): void =
  let json = toJson(yeet)
  output.writeLine(json)
