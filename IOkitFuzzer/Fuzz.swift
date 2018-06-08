//
//  Fuzz.swift
//  IOkitFuzzer
//
//  Created by 전민재 on 2018. 3. 24..
//  Copyright © 2018년 전민재. All rights reserved.
//

import Foundation
import IOKit

var inputScalar = UnsafeMutablePointer<UInt64>.allocate(capacity: 16)
let inputStuct = UnsafeMutableRawPointer.allocate(bytes: 4096, alignedTo: MemoryLayout<Int>.alignment)
let outputScalar = UnsafeMutablePointer<UInt64>.allocate(capacity: 16)
let outputStruct = UnsafeMutableRawPointer.allocate(bytes: 4096, alignedTo: MemoryLayout<Int>.alignment)
var outputStructCnt = UnsafeMutablePointer<Int>.allocate(capacity: 1)
var outputScalarCnt = UnsafeMutablePointer<UInt32>.allocate(capacity: 1)
var inputScalarCnt:UInt32 = 0;
var inputStructCnt:Int = 0

func Fuzz(name: String)
{
    var connect: io_connect_t = 0
    var iterator: io_iterator_t = 0;
    
    let matchingClass = IOServiceMatching(name)
    assert((matchingClass != nil) , "[-] Failed to get IOServiceMatching")
    print("IOServiceMatching success")

    guard IOServiceGetMatchingServices(kIOMasterPortDefault, matchingClass, &iterator) == KERN_SUCCESS else {
        print("Fail to call IOServiceGetMatchingService!")
        return
    }
    print("Success")
    let service = IOIteratorNext(iterator)
    //assert(service != IO_OBJECT_NULL, "[-] Failed to call IOIteratorNext()")
    print("IOIteratorNext success")

    let status = IOServiceOpen(service, mach_task_self_, 0, &connect)
    if status == KERN_SUCCESS{
        print("IOServiceOpen success")
    }
    print(inputScalar)
    let name = IOObjectCopyClass(service).takeRetainedValue() as String
    print(name)
    inputScalar.initialize(to: 0x00000000)

    let kr = IOConnectCallMethod(connect, UInt32(17), inputScalar, inputScalarCnt, inputStuct, inputStructCnt, outputScalar, outputScalarCnt, outputStruct, outputStructCnt)
    print(17)
    print(String(format:"0x%x",kr))
    print(outputStruct)

    print(inputScalar)
}
