//
//  main.swift
//  LLVMTemplate
//

import LLVM_C

let module = LLVMModuleCreateWithName("Hello, LLVM")
LLVMDumpModule(module)
LLVMDisposeModule(module)
