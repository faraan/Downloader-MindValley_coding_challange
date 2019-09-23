//
//  String+DownloaderTests.swift
//  PinboardDemo
//
//  Created by SYED FARAN GHANI on 21/09/19.
//  Copyright © 2019 Syed Faran Ghani. All rights reserved.
//

import XCTest
@testable import Downloader

class String_DownloaderTests: XCTestCase {

    func testEscapedFilename() {
        XCTAssertEqual("".escapedFilename(), "")
        XCTAssertEqual(":".escapedFilename(), "%3A")
        XCTAssertEqual("/".escapedFilename(), "%2F")
        XCTAssertEqual(" ".escapedFilename(), " ")
        XCTAssertEqual("\\".escapedFilename(), "\\")
        XCTAssertEqual("test".escapedFilename(), "test")
        XCTAssertEqual("http://Downloader.io".escapedFilename(), "http%3A%2F%2FDownloader.io")
        XCTAssertEqual("/path/to/file".escapedFilename(), "%2Fpath%2Fto%2Ffile")
    }
    
    func testMD5String() {
        XCTAssertEqual("".MD5String(), "d41d8cd98f00b204e9800998ecf8427e")
        XCTAssertEqual("Downloader".MD5String(), "aaf750bf2c41f921d0f5c1e9ba36f6f4")
        XCTAssertEqual("http://Downloader.io".MD5String(), "e7bbf4e61be4fe99e3dd95f99b666aa0")
        XCTAssertEqual("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam pretium id nibh a pulvinar. Integer id ex in tellus egestas placerat. Praesent ultricies libero ligula, et convallis ligula imperdiet eu. Sed gravida, turpis sed vulputate feugiat, metus nisl scelerisque diam, ac aliquet metus nisi rutrum ipsum. Nulla vulputate pretium dolor, a pellentesque nulla. Nunc pellentesque tortor porttitor, sollicitudin leo in, sollicitudin ligula. Cras malesuada orci at neque interdum elementum. Integer sed sagittis diam. Mauris non elit sed augue consequat feugiat. Nullam volutpat tortor eget tempus pretium. Sed pharetra sem vitae diam hendrerit, sit amet dapibus arcu interdum. Fusce egestas quam libero, ut efficitur turpis placerat eu. Sed velit sapien, aliquam sit amet ultricies a, bibendum ac nibh. Maecenas imperdiet, quam quis tincidunt sollicitudin, nunc tellus ornare ipsum, nec rhoncus nunc nisi a lacus.".MD5String(),
            "36acb564fdf3c31c222c3069ba1d66d1")

    }
    
    func testFilename() {
        XCTAssertEqual("".Filename(), "".MD5String())
        XCTAssertEqual("test".Filename(), "test".MD5String())
        XCTAssertEqual("test.png".Filename())
    }

    func testFilename_QueryString() {
        let sut = "test.png?width=100&height=200"
        XCTAssertEqual(sut.Filename(), (sut.MD5String() as NSString).appendingPathExtension("png"))
    }

}
