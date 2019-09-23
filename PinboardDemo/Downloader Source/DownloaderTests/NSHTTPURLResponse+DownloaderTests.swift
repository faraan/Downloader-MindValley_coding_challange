//
//  NSHTTPURLResponse+DownloaderTests.swift
//  PinboardDemo
//
//  Created by SYED FARAN GHANI on 21/09/19.
//  Copyright © 2019 Syed Faran Ghani. All rights reserved.
//

import XCTest
@testable import Downloader

func responseWithStatusCode(_ statusCode : Int) -> HTTPURLResponse {
    return HTTPURLResponse(url: URL(string: "http://Downloader.io")!, statusCode: statusCode, httpVersion: "HTTP/1.1", headerFields: nil)!
}

class NSHTTPURLResponse_DownloaderTests: XCTestCase {

    func testIsValidStatusCode() {
        XCTAssertTrue(responseWithStatusCode(200).hnk_isValidStatusCode())
        XCTAssertTrue(responseWithStatusCode(201).hnk_isValidStatusCode())
        XCTAssertFalse(responseWithStatusCode(404).hnk_isValidStatusCode())
    }

}
