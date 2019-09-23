//
//  NSHTTPURLResponse+Downloader.swift
//  PinboardDemo
//
//  Created by SYED FARAN GHANI on 21/09/19.
//  Copyright © 2019 Syed Faran Ghani. All rights reserved.
//

import Foundation

extension HTTPURLResponse {

    func hnk_isValidStatusCode() -> Bool {
        switch self.statusCode {
        case 200...201:
            return true
        default:
            return false
        }
    }

}
