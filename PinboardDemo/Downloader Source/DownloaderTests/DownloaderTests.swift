//
//  DownloaderTests.swift
//  PinboardDemo
//
//  Created by SYED FARAN GHANI on 21/09/19.
//  Copyright © 2019 Syed Faran Ghani. All rights reserved.
//

import XCTest
@testable import Downloader

class DownloaderTests: XCTestCase {

    func testErrorWithCode() {
        let code = 200
        let description = self.name
        let error = errorWithCode(code, description: description)
        
        XCTAssertEqual(error._domain, DownloaderGlobals.Domain)
        XCTAssertEqual(error._code, code)
        XCTAssertEqual(error.localizedDescription, description)
    }
    
    func testSharedImageCache() {
        XCTAssertNoThrow(Shared.imageCache)
    }
    
    func testSharedDataCache() {
        XCTAssertNoThrow(_ = Shared.dataCache)
    }
    
    func testSharedStringCache() {
        XCTAssertNoThrow(_ = Shared.stringCache)
    }
    
    func testSharedJSONCache() {
        XCTAssertNoThrow(_ = Shared.JSONCache)
    }
    
}
