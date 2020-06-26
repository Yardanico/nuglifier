import os, strutils, strformat, random, parseutils, sugar, lexer, tables

const
  ZeroWidthSpace = "​"
  Prelude = fmt"""
#? replace("{ZeroWidthSpace}"," ") | replace("\t"," ")"""
  MaybeUsableIndents = [ZeroWidthSpace, "\t", " "]
  MinDiff = 1
  MaxDiff = 3

proc main(data: string, mode: ProcessingMode): string = 
  randomize()

  #if paramCount() < 1:
  #  quit "Usage: nuglifier file.nim"
  let src = processStuff(data, mode) #readFile(paramStr(1))
  result.add Prelude

  var i = 0
  if mode == EmojiCursed:
    result.add " | "
    for (orig, replace) in tabler.pairs():
      result.add &"replace(\"{replace}\",\"{orig}\")"
      if i < tabler.len - 1:
        result.add " | "
      inc i
  result.add "\n"
  type
    IndentLevel = object
      curLevel: int
      indentCount: int
      indent: string
  var 
    depth = 0
    lastIndent = 0
    indents: seq[IndentLevel]
  
  for line in src.splitLines():
    let curIndent = line.skipWhitespace()
    var noIndLine = line[curIndent .. ^1]
    if noIndLine.startsWith("#") or noIndLine.strip() == "": continue
    if lastIndent > curIndent:
      while indents.len > 0 and curIndent < indents[^1].curLevel:
        dec depth
        discard indents.pop()

    elif lastIndent < curIndent:
      #echo repr line
      inc depth
      let lastInd = if indents.len == 0: 0 else: indents[^1].indentCount
      let cnt = lastInd + rand(MinDiff .. MaxDiff)
      let ind = IndentLevel(
        curLevel: curIndent,
        indentCount: cnt,
        indent: sample(MaybeUsableIndents)
      )
      indents.add ind
      #echo indents
      #indentCounts.add cnt
      # indentLevels.add curIndent
    else:
      discard
    
    let indentStr = if depth > 0:
      sample(MaybeUsableIndents).repeat(indents[^1].indentCount)
    else:
      ""
    
    var words = noIndLine.split()

    noIndLine = words.join(sample(MaybeUsableIndents).repeat(rand MinDiff .. MaxDiff))

    result.add indentStr & noIndLine & "\n"

    lastIndent = curIndent

when isMainModule:
  if paramCount() < 3:
    quit("./nuglifier emoji|case source.nim dest.nim")
  
  let modeParam = paramStr(1)
  let mode = 
    if modeParam == "emoji": EmojiCursed 
    elif modeParam == "case": CaseInsensitivity
    else: quit "Allowed modes - 'emoji' and 'case'"
  let srcFile = paramStr(2)
  let destFile = paramStr(3)

  let res = readFile(srcFile).main(mode)

  writeFile(destFile, res)