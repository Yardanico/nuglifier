import std / [
  os, strutils, strformat, random, parseutils, tables
]

import compiler / [
  options, idents, llstream, pathutils, lexer
]

const
  ZeroWidthSpace = "​"
  Prelude = fmt"""
#? replace("{ZeroWidthSpace}"," ") | replace("\t"," ")"""
  MaybeUsableIndents = [ZeroWidthSpace, "\t", " "]
  MinDiff = 1
  MaxDiff = 3

# So we can remove used emojis
var Emojis = @["😀","😬","😂","😄","😅","😇","☺️","😋","😘","😚","😜","🤑","😎","🤗","😳","🙄","😤","😱","😨","😰","😥","🤒","😭","💩","👹","💀","👻","👽","🤖","😺","😹","😻","😼","😽","🙀","😿","😾","🙌","👏","👋","👍","👊","✊","✌️","👌","✋","👐","💪","☝️","🙏","👆","🖐","🤘","🖖","✍️","💅","👄","👅","👂","👁","👀","👶","👦","👧","👨","👩","👱","👴","👵","👲","👳","👷","💂","🕵","🎅","👼","👸","👰","🚶","🏃","💃","👯","👫","👬","👭","🙇","💁","🙅","🙆","🙋","🙎","🙍","💇","💆","💑","👨‍❤️‍👨","💏","👩‍❤️‍💋‍👩","👨‍❤️‍💋‍👨","👩‍👩‍👦","👨‍👨‍👦","👮","👚","👕","👖","👔","👗","👙","👘","💄","💋","🎩","👟","👞","👢","👡","👠","👣","⛑","🎓","👑","🎒","👝","👛","👜","💼","🌂","💍","🕶","👓","🐯","🦁","🐮","🐷","🐽","🐸","🐙","🐵","🐦","🐧","🐔","🐒","🙉","🙈","🐣","🐥","🐺","🐗","🐴","🦄","🐝","🐛","🐢","🦀","🦂","🕷","🐜","🐞","🐌","🐠","🐟","🐡","🐬","🐋","🐊","🐆","🐘","🐫","🐪","🐄","🐂","🐃","🐏","🐑","🐀","🐁","🐓","🦃","🐉","🐾","🐿","🐇","🐈","🐩","🐕","🐲","🌵","🎄","🌲","🌴","🌱","🌿","🌾","🍁","🍂","🍃","🎋","🎍","🍀","🌺","🌻","🌹","🌷","🌼","🌸","💐","🍄","🎃","🐚","🌎","🌍","🌏","🌕","🌖","🌗","🌘","🌑","🌒","🌓","🌔","🌚","🌝","🌛","🌜","🌞","⭐️","🌟","💫","✨","☄️","🌥","🌦","🌧","⛈","⚡️","🔥","❄️","🌨","☔️","☂️","🌪","💨","☃️","⛄️","💧","💦","🌊","🍏","🍎","🍐","🍋","🍌","🍉","🍇","🌶","🍅","🍍","🍑","🍈","🍓","🌽","🍠","🍯","🍞","🍗","🧀","🍖","🍤","🌯","🌮","🍝","🍕","🌭","🍟","🍔","🍳","🍜","🍲","🍥","🍣","🍱","🍛","🍙","🍚","🎂","🍰","🍦","🍨","🍧","🍡","🍢","🍘","🍮","🍬","🍭","🍫","🍿","🍩","🍪","🍺","☕️","🍵","🍶","🍹","🍻","🍼","🍴","🍷","🍽","⚽️","🏀","🏈","⚾️","🎾","🏐","🏉","🎱","🎿","🏏","🏑","🏓","🏌","⛳️","⛷","🏂","⛸","🏹","🎣","🚣","🏊🏼","🏄","🏆","🕴","🏇","🚵","🚴","🏋","⛹","🛀","🎽","🏅","🎖","🎗","🏵","🎫","🎟","🎭","🎺","🎷","🎹","🎤","🎪","🎨","🎸","🎻","🎬","🎮","👾","🎯","🎲","🎰","🎳","🚗","🚕","🚙","🚌","🚎","🏎","🚓","🚒","🚐","🚛","🚜","🏍","🚲","🚨","🚃","🚟","🚠","🚡","🚖","🚘","🚍","🚔","🚋","🚝","🚄","🚅","🚈","🚞","🚂","🚆","🛬","🛫","✈️","🛩","🚁","🚉","🚊","🚇","⛵️","🛥","🚤","⛴","🚀","🛳","🛰","💺","🏁","🚥","🚦","🚏","⛽️","🚧","⚓️","🎡","🎢","🎠","🏗","🌁","🗼","🏭","⛲️","⛺️","🏕","🗾","🌋","🗻","🏔","⛰","🎑","🏞","🛣","🛤","🌅","🌄","🏜","🏖","🏝","🎇","🌠","🌌","🌉","🌃","🏙","🌆","🌇","🎆","🌈","🏘","🏰","🏯","🏠","🗽","🏟","🏡","🏚","🏢","🏬","🏣","🏤","🏥","🏦","🕌","⛪️","🏛","💒","🏩","🏫","🏪","🏨","🕍","🕋","⛩","🕹","💽","💾","💿","📼","📷","📹","🎥","☎️","⏱","🎙","📻","📺","📠","📟","⏲","⏰","🕰","⏳","📡","🔋","💴","💵","💸","🛢","🔦","💡","💶","💷","💰","💳","💎","🔨","💣","🔫","🔪","☠️","🔮","💈","💊","💉","🔖","🚿","🔑","🛋","🚪","🛎","🖼","🎁","🎀","🎏","🎈","🛍","⛱","🗺","🎊","🎉","🎎","🎐","🎌","🏮","📮","📫","📯","📊","🗃","📇","📅","📉","📈","📰","📕","📙","📒","✂️","🖇","📖","📚","📌","📍","🚩","❤️","💔","❣️","💕","💓","💗","💖","💘","💝","💠","🔔"]

type
  ProcessingMode* = enum EmojiCursed, CaseInsensitivity

var tabler* = newTable[string, string]()

proc randomEmoji(word: string): string = 
  if word.len == 0: return
  if word notin tabler:
    let idx = rand(0 ..< Emojis.len)
    tabler[word] = Emojis[idx]
    Emojis.del idx

  result = tabler[word]

proc randomCase(word: string): string = 
  if word.len == 0: return
  result = newStringOfCap(word.len)
  result.add word[0]
  var addedUnderscore = false
  for i in 1 ..< word.len:
    let letter = word[i]
    if addedUnderscore:
      addedUnderscore = false
    elif rand(0 .. 100) > 30 and i in 2 ..< word.len - 1:
      addedUnderscore = true
      result.add "_"
    if rand(0 .. 100) < 40:
      result.add letter
    else:
      result.add toUpperAscii(letter)

proc processStuff(src: string, mode: ProcessingMode): string = 
  var cache = newIdentCache()
  var config = newConfigRef()
  var f = AbsoluteFile"input.nim"
  var stream = llStreamOpen(src)
  result = src
  var 
    L: TLexer
    tok: TToken
  openLexer(L, f, stream, cache, config)
  rawGetTok(L, tok)
  var myOffset = 0
  while tok.tokType != tkEof:
    if (tok.tokType == tkSymbol or tok.tokType in tokKeywordLow .. tokKeywordHigh):# and tok.ident.s notin Blacklist:
      let newWord = 
        if mode == EmojiCursed: randomEmoji(tok.ident.s)
        else: randomCase(tok.ident.s)
      let origLen = tok.offsetB - tok.offsetA
      let newLen = newWord.len - 1
      result[tok.offsetA + myOffset .. tok.offsetB + myOffset] = newWord
      myOffset += newLen - origLen
    elif tok.tokType == tkStrLit:
      let old = tok.literal
      var newugly = "\""
      for c in old:
        newugly.add "\\x" & toHex($c)
      newugly.add "\""
      let origLen = tok.offsetB - tok.offsetA
      let newLen = newugly.len - 1
      result[tok.offsetA + myOffset .. tok.offsetB + myOffset] = newugly
      myOffset += newLen - origLen
    rawGetTok(L, tok)

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