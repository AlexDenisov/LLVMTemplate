//
//  Helpers.swift
//  LLVMTemplate
//

import Foundation
import LLVM_C

func loadModuleAtPath(_ path: String) -> LLVMModuleRef {
    let errorMessage = UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>.allocate(capacity: 1)
    let buffer = UnsafeMutablePointer<LLVMMemoryBufferRef?>.allocate(capacity: 1)
    let module = UnsafeMutablePointer<LLVMModuleRef?>.allocate(capacity: 1)

    defer {
        errorMessage.deallocate(capacity: 1)
        buffer.deallocate(capacity: 1)
        module.deallocate(capacity: 1)
    }

    if LLVMCreateMemoryBufferWithContentsOfFile(path, buffer, errorMessage) != 0 {
        print("Can't load module '\(path)': \(String(cString: errorMessage.pointee!))")
        exit(1)
    }

    defer {
        LLVMDisposeMemoryBuffer(buffer.pointee)
    }

    if LLVMParseBitcodeInContext2(LLVMGetGlobalContext(), buffer.pointee, module) != 0 {
        print("Can't load module '\(path)'")
        exit(1)
    }

    let resultingModule = LLVMCloneModule(module.pointee)

    return resultingModule!
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

func iterateOverFunctions(_ module: LLVMModuleRef, yield: (LLVMValueRef) -> ()) {
    var function = LLVMGetFirstFunction(module)
    while function != nil {
        yield(function!)
        function = LLVMGetNextFunction(function)
    }
}

func iterateOverInstructions(_ function: LLVMValueRef, yield: (LLVMValueRef) -> ()) {
    var basicBlock = LLVMGetFirstBasicBlock(function)

    while basicBlock != nil {
        var instruction = LLVMGetFirstInstruction(basicBlock)

        while instruction != nil {
            yield(instruction!)
            instruction = LLVMGetNextInstruction(instruction)
        }

        basicBlock = LLVMGetNextBasicBlock(basicBlock)
    }
}
