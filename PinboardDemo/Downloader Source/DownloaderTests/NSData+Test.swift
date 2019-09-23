//
//  NSData.swift
//  PinboardDemo
//
//  Created by SYED FARAN GHANI on 21/09/19.
//  Copyright © 2019 Syed Faran Ghani. All rights reserved.
//

import Foundation

extension Data {
    
    static func dataWithLength(_ length : Int) -> Data {
        let buffer: [UInt8] = [UInt8](repeating: 0, count: length)
//        return Data(bytes: UnsafePointer<UInt8>(&buffer), count: length)
        let pointer = UnsafeRawPointer(buffer)

        return NSData(bytes: pointer, length: length) as Data
    }
    
}
