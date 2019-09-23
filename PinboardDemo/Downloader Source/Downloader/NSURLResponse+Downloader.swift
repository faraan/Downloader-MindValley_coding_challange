//
//  NSHTTPURLResponse+Downloader.swift
//  PinboardDemo
//
//  Created by SYED FARAN GHANI on 21/09/19.
//  Copyright © 2019 Syed Faran Ghani. All rights reserved.
//

import Foundation

extension URLResponse {
    
    func hnk_validateLength(ofData data: Data) -> Bool {
        let expectedContentLength = self.expectedContentLength
        if (expectedContentLength > -1) {
            let dataLength = data.count
            return Int64(dataLength) >= expectedContentLength
        }
        return true
    }
    
}
