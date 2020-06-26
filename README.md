# Nuglifier - a Nim pretty-printing tool

This is proof of concept Nim pretty-printing software. Right now it only allows you to format
your code using emojis and case insensitivity, but there's more to come (I hope).

Compiling:
```
$ nimble build
```

Usage:
```sh
$ ./nuglifier MODE sourcefile.nim resultfile.nim
```

where MODE is either `emoji` or `case`.

Feel free to submit your feedback, how you feel after looking at the resulting code, why I should remove this repo, etc...

KNOWN BUGS:
- [ ] Imports break when formatting with the `case` mode.