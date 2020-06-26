import math, strutils, parseutils, tables, strformat

type
  MathFunction* = proc(args: seq[float]): float ## \
  ## Type of the procedure definition for custom math functions

  MathCustomFun = object
    # Number of arguments this function is allowed to be called with
    argCount: int
    # The function itself
    fun: MathFunction

  MathExpression = object
    eval: Evaluator
    input: string
    len: int
    ch: char
    pos: int

  Evaluator* = ref object
    ## Main instance of the math evaluator
    hasFuncs: bool
    hasVars: bool
    funcs: TableRef[string, MathCustomFun]
    vars: TableRef[string, float]

proc atEnd(expr: var MathExpression): bool =
  expr.pos >= expr.len

proc incPos(expr: var MathExpression, addPos = 1): char {.discardable.} =
  # Increments current pos by 'addPos' characters
  expr.pos += addPos
  expr.ch = if expr.atEnd(): '\0' else: expr.input[expr.pos]

proc nextOp(expr: var MathExpression, opList: set[char]): char =
  # Checks if the next character is an op from the 'opList'
  # If yes, returns that character, otherwise returns '\0'
  expr.incPos(skipWhitespace(expr.input, expr.pos))
  if expr.ch in opList:
    result = expr.ch
    expr.incPos()
  else:
    result = '\0'

proc eat(expr: var MathExpression, toEat: char): bool =
  # Skips all whitespace characters and checks if
  # current character is 'toEat'. If so, gets the next char
  # and returns true
  expr.incPos(skipWhitespace(expr.input, expr.pos))
  if expr.ch == toEat:
    expr.incPos()
    true
  else: false

# Forward declaration because of recursive dependency
proc parseExpression(expr: var MathExpression): float
proc parseFactor(expr: var MathExpression): float

proc expectedParen(expr: var MathExpression) =
  raise newException(ValueError, &"Expected ')', found '{expr.ch}'")

proc unknownIdent(funcName: string) =
  raise newException(ValueError, &"Ident '{funcName}' is not defined")

proc unexpectedChar(expr: var MathExpression) =
  raise newException(ValueError, &"Unexpected character '{expr.ch}'")

proc getArgs(expr: var MathExpression, zeroArg = true): seq[float] =
  # Gets argument list for a function call
  result = @[]
  if expr.eat('('):
    # Empty function call like a()
    if expr.eat(')'): return
    # Until it's the end of the argument list
    while expr.ch != ')':
      result.add expr.parseExpression()
      # ',' is not mandatory, since we allow things like max(1 2 3 4 5)
      if expr.ch == ',': expr.incPos()
    # We didn't find the closing paren
    if not expr.eat(')'):
      expr.expectedParen()
  else:
    # Parse a factor. It can't be an expression because this
    # would provide wrong results: sqrt 100 * 70
    result.add expr.parseFactor()

proc checkArgLen(expected, actual: int, funcName: string) =
  if expected == -1 and actual < 1:
    raise newException(ValueError,
      &"Expected at least one argument for '{funcName}', got 0"
    )
  elif expected != -1 and actual != expected:
    raise newException(ValueError,
      &"Expected {expected} arguments for '{funcName}', got {actual}"
    )

proc parseFactor(expr: var MathExpression): float =
  # Unary + and -
  if expr.eat('+'): return expr.parseFactor()
  elif expr.eat('-'): return -expr.parseFactor()

  if expr.eat('('):
    result = expr.parseExpression()
    if not expr.eat(')'):
      expr.expectedParen()

  elif expr.ch in IdentStartChars:
    var funcName: string
    expr.incPos(parseIdent(expr.input, funcName, expr.pos))

    if expr.eval.hasVars and funcName in expr.eval.vars:
      return expr.eval.vars[funcName]

    if expr.eval.hasFuncs:
      let data = expr.eval.funcs.getOrDefault(funcName)
      if not data.fun.isNil():
        # Check number of arguments passed to a custom function
        let args = expr.getArgs()
        checkArgLen(data.argCount, args.len, funcName)
        return data.fun(args)

    # Built-in constants
    result = case funcName
    of "pi": PI
    of "tau": TAU
    of "e": E
    else: 0
    # If this is a constant, immediately return
    if result != 0: return

    # We are *kinda* sure that we're handling a function now
    let args = expr.getArgs()

    template callArgs(fnCall: untyped, argCount = 1): float =
      # Check that the number of passed arguments is `argCount`
      # and then does `fnCall`
      checkArgLen(argCount, args.len, funcName)
      fnCall

    result = case funcName
    of "abs":
      callArgs abs(args[0])
    of "acos", "arccos":
      callArgs arccos(args[0])
    of "asin", "arcsin":
      callArgs arcsin(args[0])
    of "atan", "arctan", "arctg":
      callArgs arctan(args[0])
    of "atan2", "arctan2":
      callArgs arctan2(args[0], args[1]), 2
    of "ceil":
      callArgs ceil(args[0])
    of "cos":
      callArgs cos(args[0])
    of "cosh":
      callArgs cosh(args[0])
    of "deg":
      callArgs radToDeg(args[0])
    of "exp":
      callArgs exp(args[0])
    of "sgn":
      callArgs float(sgn(args[0]))
    of "sqrt":
      callArgs sqrt(args[0])
    of "sum":
      callArgs sum(args), -1
    of "fac":
      callArgs float(fac(int(args[0])))
    of "floor":
      callArgs floor(args[0])
    of "ln":
      callArgs ln(args[0])
    of "log", "log10":
      callArgs log10(args[0])
    of "log2":
      callArgs log2(args[0])
    of "max":
      callArgs max(args), -1
    of "min":
      callArgs min(args), -1
    of "ncr", "binom":
      callArgs float(binom(int args[0], int args[1])), 2
    of "npr":
      callArgs float(binom(int args[0], int args[1]) * fac(int args[1])), 2
    of "rad":
      callArgs degToRad(args[0])
    of "pow":
      callArgs pow(args[0], args[1]), 2
    of "sin":
      callArgs sin(args[0])
    of "sinh":
      callArgs sinh(args[0])
    of "tg", "tan":
      callArgs tan(args[0])
    of "tanh":
      callArgs tanh(args[0])
    else:
      unknownIdent(funcname)
      NaN

  # Numbers ('.' is for numbers like '.5')
  elif expr.ch in {'0'..'9', '.'}:
    expr.incPos(parseFloat(expr.input, result, expr.pos))

  else:
    expr.unexpectedChar()

proc parseTerm(expr: var MathExpression): float =
  result = expr.parseFactor()
  while not expr.atEnd():
    case expr.nextOp({'*', '/', '%', '^'})
    of '*': result *= expr.parseFactor()
    of '/': result /= expr.parseFactor()
    of '%': result = result.mod(expr.parseFactor())
    of '^': result = result.pow(expr.parseFactor())
    else: break

proc parseExpression(expr: var MathExpression): float =
  result = expr.parseTerm()
  while not expr.atEnd():
    case expr.nextOp({'+', '-'})
    of '+': result += expr.parseTerm()
    of '-': result -= expr.parseTerm()
    else: break

proc parse(expr: var MathExpression): float =
  result = expr.parseExpression()
  # We should parse the whole input, otherwise we skipped something
  # and that's certainly not good
  if not expr.atEnd(): expr.unexpectedChar()

proc newEvaluator*: Evaluator =
  ## Creates a new evaluator instance for evaluating math expressions
  ##
  ##
  ## There's no limit on the number of evaluator instances,
  ## and all functions and math procedures are local to the current instance
  Evaluator(
    vars: newTable[string, float](),
    hasVars: false,
    funcs: newTable[string, MathCustomFun](),
    hasFuncs: false
  )

proc addFunc*(e: Evaluator, name: string, fun: MathFunction, argCount = -1) =
  ## Adds custom function `fun` with the name `name` to the evaluator `e`
  ## which will then be available inside of all following `e.eval()` calls.
  ##
  ## `argCount` specifies the number of arguments this function is allowed
  ## to be called with. If it is `-1`, the function will be able to be called
  ## with one or more arguments, otherwise - only with `argCount` arguments.
  e.hasFuncs = true
  e.funcs[name] = MathCustomFun(fun: fun, argCount: argCount)

proc removeFunc*(e: Evaluator, name: string) =
  ## Removes function with the name `name` from the evaluator `e`
  e.funcs.del(name)
  if e.funcs.len == 0:
    e.hasFuncs = false

proc addVar*(e: Evaluator, name: string, val: float) =
  ## Adds a constant with the name `name` to the evaluator `e`
  e.hasVars = true
  e.vars[name] = val

proc addVars*(e: Evaluator, vars: openArray[(string, float)]) =
  ## Adds all constants from the `vars` openArray to the evaluator `e`
  runnableExamples:
    let e = newEvaluator()
    e.addVars({"a": 3.0, "b": 5.5})
    assert e.eval("a ^ a + b") == 32.5

  for (name, val) in vars:
    e.addVar(name, val)

proc removeVar*(e: Evaluator, name: string) =
  ## Removes the specified constant with the name `name` from the evaluator `e`
  e.vars.del(name)
  if e.vars.len == 0:
    e.hasVars = false

proc eval*(e: Evaluator, input: string): float =
  ## Evaluates a math expression from `input` and returns result as `float`
  ##
  ## Can raise an exception if `input` is invalid or an overflow occured
  if input.len == 0:
    raise newException(ValueError, "The line is empty!")

  var expr = MathExpression(
    eval: e,
    len: input.len,
    ch: input[0],
    input: input,
    pos: 0
  )

  expr.parse()

let e = newEvaluator()
echo "2+2*2 = ", e.eval("2+2 * 2")