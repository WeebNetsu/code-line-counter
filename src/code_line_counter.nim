from std/os import execShellCmd
from std/strutils import split, parseInt, strip
from std/sequtils import map, filter
import std/strformat

const
    # all the folders to ignore when counting
    ignoreDirs = ["node_modules", ".meteor"]
    # the files with these extensions will be counted
    searchExts = ["ts", "tsx"]
    outputFile = "count.clc"

var exeCommand = "("

for ext in searchExts:
    if len(exeCommand) > 1:
        exeCommand &= "&& "

    exeCommand &= &"""find . -name "*.{ext}" """

    for dir in ignoreDirs:
        exeCommand &= &"""-not -path "*/{dir}/*" """

    exeCommand &= """-exec wc -l {} \; """

exeCommand &= &""") | grep -Eo '^[^ ]+' >> {outputFile}"""

# should generate """(find . -name "*.ts" -not -path "*/node_modules/*" -not -path "*/.meteor/*" -exec wc -l {} \; && find . -name "*.tsx" -not -path "*/node_modules/*" -not -path "*/.meteor/*" -exec wc -l {} \;) | grep -Eo '^[^ ]+' > {{outputFile}}"""
# echo exeCommand

# count all the lines in all the .tsx and .ts files
discard execShellCmd(exeCommand)

let linesOfCode = readFile(outputFile).split('\n').map(proc (word: string): int = (if word.strip() != "": parseInt(word) else: 0))

var total = 0

for number in linesOfCode:
    total += number

echo total
