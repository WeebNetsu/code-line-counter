# Code Line Counter

Will count the amount of lines in your codebase, this is a simple project that just generates a couple lines of shell code, might convert it to pure Nim at some point.

## Requirements

- OS: Linux or Mac
- Software: `Nim`, `Nimble`, `find`, `grep`

## How to use

1. Open `src/code_line_counter.nim`
2. Edit the `ignoreDirs` and `searchExts` constants to fit the needs of your codebase
3. `nimble build`
4. Copy the generated executable to your codebase and run it
