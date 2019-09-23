//
//  CGSize+DownloaderTests.swift
//  PinboardDemo
//
//  Created by SYED FARAN GHANI on 21/09/19.
//  Copyright © 2019 Syed Faran Ghani. All rights reserved.
//

import UIKit
import XCTest
@testable import Downloader

class CGSize_DownloaderTests: XCTestCase {
    
    func testAspectFillSize() {
        let image = UIImage.imageWithColor(UIColor.red, CGSize(width: 10, height: 1), false)
        let sut: CGSize = image.size.hnk_aspectFillSize(CGSize(width: 10, height: 10))
        
        XCTAssertTrue(sut.height == 10)
    }
    
    func testAspectFitSize() {
        let image = UIImage.imageWithColor(UIColor.red, CGSize(width: 10, height: 1), false)
        let sut: CGSize = image.size.hnk_aspectFitSize(CGSize(width: 20, height: 20))
        
        XCTAssertTrue(sut.height == 2)
    }
}
