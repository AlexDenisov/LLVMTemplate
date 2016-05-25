//
//  main.swift
//  LLVMTemplate
//

import LLVM_C

let modules = [sampleMathModule(), sampleFindMaxModule(), sampleFibModule()]

defer {
    for module in modules {
        LLVMDisposeModule(module)
    }
}

for module in modules {
    iterateOverFunctions(module) { (function) in
        let name = LLVMGetValueName(function)
        print("\(String.fromCString(name)!):")
        iterateOverInstructions(function) { (instruction) in
            LLVMDumpValue(instruction)
        }
        print()
    }
}
