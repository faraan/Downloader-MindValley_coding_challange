//
//  Downloader.swift
//  PinboardDemo
//
//  Created by SYED FARAN GHANI on 21/09/19.
//  Copyright © 2019 Syed Faran Ghani. All rights reserved.
//

import UIKit

public struct DownloaderGlobals {
    
    public static let Domain = "com.mindvalley"
    
}

public struct Shared {
    
    public static var imageCache : Cache<UIImage> {
        struct Static {
            static let name = "shared-images"
            static let cache = Cache<UIImage>(name: name)
        }
        return Static.cache
    }
    
    public static var dataCache : Cache<Data> {
        struct Static {
            static let name = "shared-data"
            static let cache = Cache<Data>(name: name)
        }
        return Static.cache
    }
    
    public static var stringCache : Cache<String> {
        struct Static {
            static let name = "shared-strings"
            static let cache = Cache<String>(name: name)
        }
        return Static.cache
    }
    
    public static var JSONCache : Cache<JSON> {
        struct Static {
            static let name = "shared-json"
            static let cache = Cache<JSON>(name: name)
        }
        return Static.cache
    }
}

func errorWithCode(_ code: Int, description: String) -> Error {
    let userInfo = [NSLocalizedDescriptionKey: description]
    return NSError(domain: DownloaderGlobals.Domain, code: code, userInfo: userInfo) as Error
}
