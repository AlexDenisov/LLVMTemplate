//
//  Helpers.swift
//  LLVMTemplate
//

import Foundation
import LLVM_C

func loadModuleAtPath(path: String) -> LLVMModuleRef {
    let errorMessage = UnsafeMutablePointer<UnsafeMutablePointer<Int8>>.alloc(1)
    let buffer = UnsafeMutablePointer<LLVMMemoryBufferRef>.alloc(1)
    let module = UnsafeMutablePointer<LLVMModuleRef>.alloc(1)

    defer {
        errorMessage.dealloc(1)
        buffer.dealloc(1)
        module.dealloc(1)
    }

    if LLVMCreateMemoryBufferWithContentsOfFile(path, buffer, errorMessage) != 0 {
        print("Can't load module '\(path)': \(String.fromCString(errorMessage.memory)!)")
        exit(1)
    }

    defer {
        LLVMDisposeMemoryBuffer(buffer.memory)
    }

    if LLVMParseBitcodeInContext2(LLVMGetGlobalContext(), buffer.memory, module) != 0 {
        print("Can't load module '\(path)'")
        exit(1)
    }

    let resultingModule = LLVMCloneModule(module.memory)

    return resultingModule
}

func sampleMathModule() -> LLVMModuleRef {
    let path = "./samples/math.bc"
    return loadModuleAtPath(path)
}

func sampleFibModule() -> LLVMModuleRef {
    let path = "./samples/fib.bc"
    return loadModuleAtPath(path)
}

func sampleFindMaxModule() -> LLVMModuleRef {
    let path = "./samples/find_max.bc"
    return loadModuleAtPath(path)
}
