//
//  main.swift
//  LLVMTemplate
//

import LLVM_C

let modules = [sampleMathModule(), sampleFibModule(), sampleFindMaxModule()]

defer {
    for module in modules {
        LLVMDisposeModule(module)
    }
}

for module in modules {
    LLVMDumpModule(module)
}
