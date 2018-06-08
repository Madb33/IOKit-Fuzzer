//
//  main.swift
//  IOkitFuzzer
//
//  Created by 전민재 on 2018. 3. 19..
//  Copyright © 2018년 전민재. All rights reserved.
//

import IOKit
import Foundation

func getClass(){
    var master_port: mach_port_t = mach_port_t(MACH_PORT_NULL)
    var iter: io_iterator_t = 0
    var obj: io_object_t = 0;

    var _service = IOServiceGetMatchingServices(kIOMasterPortDefault, IOServiceMatching("IOSurface"), &iter)
    obj = IOIteratorNext(iter)
    var classname = IOObjectCopyClass(obj)//String(describing: IOObjectCopyClass(obj))
    print(classname) //AppleHSSPIHIDDriver
}

Fuzz(name: "IOSurfaceRootUserClient")
