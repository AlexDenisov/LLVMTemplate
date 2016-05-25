# LLVMTemplate

LLVM + Swift Xcode template project

## Installation

```
git clone git@github.com:AlexDenisov/LLVMTemplate.git
make setup
make build
open LLVMTemplate.xcodeproj
```

The commands above will fetch and build LLVM sources for you.

_Note:_ By default the 'build system' will use `$(HOME)/LLVM/src` and `$(HOME)/LLVM/build` for source and build directories respectively. These values can be changed at `LLVM.xcconfig`.

## Usage

Everything you need is to open the Xcode project and start exploring `main.swift` and `Helpers.swift`.
I included few sample modules to play with, they may be created using the following method calls: `sampleMathModule()`, `sampleFindMaxModule()`, `sampleFibModule()`.

Enjoy and happy hacking!

## License

This is free and unencumbered software released into the public domain.

