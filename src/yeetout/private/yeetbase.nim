import std/sequtils
import macros

type
  YeetLevel* = enum
    yLvlDebug = "debug",
    yLvlInfo = "info",
    yLvlWarn = "warn",
    yLvlError = "error"
  ArgumentValueKind* = enum
    avkString,
    avkSeq
  ArgumentValue* = ref ArgumentValueObj
  ArgumentValueObj = object
    case kind*: ArgumentValueKind
    of avkString: stringVal*: string
    of avkSeq: seqVal*: seq[ArgumentValue]
  Argument* = (string, ArgumentValue)
  Yeet* = tuple
    level: YeetLevel
    message: string
    arguments: seq[Argument]
  Yeeter* = ref object of RootObj

method yeet*(this: Yeeter, yeet: Yeet, output: File): void {.base.} = return

type NoOpYeeter* = ref object of Yeeter

template strArgVal(value: string): ArgumentValue =
  ArgumentValue(kind: avkString, stringVal: value)

template strArg*(key: string, value: string): Argument =
  (key, strArgVal(value))

template arrArg*(key: string, value: openArray[ArgumentValue]): Argument =
  (key, ArgumentValue(kind: avkSeq, seqVal: value.toSeq))  

template arrArg*(key: string, value: openArray[string]): Argument =
  (key, ArgumentValue(kind: avkSeq, seqVal: value.mapIt(strArgVal(it))))
  