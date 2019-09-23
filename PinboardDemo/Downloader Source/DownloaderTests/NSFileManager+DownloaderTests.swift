//
//  NSFileManager+DownloaderTests.swift
//  PinboardDemo
//
//  Created by SYED FARAN GHANI on 21/09/19.
//  Copyright © 2019 Syed Faran Ghani. All rights reserved.
//

import XCTest
@testable import Downloader

class NSFileManager_DownloaderTests: DiskTestCase {
    
    func testEnumerateContentsOfDirectoryAtPathEmpty() {
        let sut = FileManager.default

        sut.enumerateContentsOfDirectory(atPath: self.directoryPath, orderedByProperty: URLResourceKey.nameKey.rawValue, ascending: true, usingBlock: { (URL : Foundation.URL, index : Int, _) -> Void in
            XCTFail()
            })
    }
    
    func testEnumerateContentsOfDirectoryAtPathStop() {
        let sut = FileManager.default
        _ = [self.writeDataWithLength(1), self.writeDataWithLength(2)]
        var count = 0
        
        sut.enumerateContentsOfDirectory(atPath: self.directoryPath, orderedByProperty: URLResourceKey.nameKey.rawValue, ascending: true) { (_ : URL, index : Int, stop : inout Bool) -> Void in
            count += 1
            stop = true
        }
        
        XCTAssertEqual(count, 1)
    }
    
    func testEnumerateContentsOfDirectoryAtPathNameAscending() {
        let sut = FileManager.default
    
        let paths = [self.writeDataWithLength(1), self.writeDataWithLength(2)].sorted(by: <)
        var resultPaths : [String] = []
        var indexes : [Int] = []
        
        sut.enumerateContentsOfDirectory(atPath: self.directoryPath, orderedByProperty: URLResourceKey.nameKey.rawValue, ascending: true) { (URL : Foundation.URL, index : Int, _) -> Void in
            resultPaths.append(URL.path)
            indexes.append(index)
        }
        
        XCTAssertEqual(resultPaths.count, 2)
        XCTAssertEqual(resultPaths, paths)
        XCTAssertEqual(indexes[0], 0)
        XCTAssertEqual(indexes[1], 1)
    }
    
    func testEnumerateContentsOfDirectoryAtPathNameDescending() {
        let sut = FileManager.default
        
        let paths = [self.writeDataWithLength(1), self.writeDataWithLength(2)].sorted(by: >)
        var resultPaths : [String] = []
        var indexes : [Int] = []
        
        sut.enumerateContentsOfDirectory(atPath: self.directoryPath, orderedByProperty: URLResourceKey.nameKey.rawValue, ascending: false) { (URL : Foundation.URL, index : Int, _) -> Void in
            resultPaths.append(URL.path)
            indexes.append(index)
        }
        
        XCTAssertEqual(resultPaths.count, 2)
        XCTAssertEqual(resultPaths, paths)
        XCTAssertEqual(indexes[0], 0)
        XCTAssertEqual(indexes[1], 1)
    }
    
    func testEnumerateContentsOfDirectoryAtPathFileSizeAscending() {
        let sut = FileManager.default
        
        let paths = [self.writeDataWithLength(1), self.writeDataWithLength(2)]
        var resultPaths : [String] = []
        
        sut.enumerateContentsOfDirectory(atPath: self.directoryPath, orderedByProperty: URLResourceKey.fileSizeKey.rawValue, ascending: true) { (URL : Foundation.URL, index : Int, _) -> Void in
            resultPaths.append(URL.path)
        }
        
        XCTAssertEqual(resultPaths.count, 2)
        XCTAssertEqual(resultPaths, paths)
    }
    
    func testEnumerateContentsOfDirectoryAtPathFileSizeDescending() {
        let sut = FileManager.default
        
        let paths : [String] = [self.writeDataWithLength(1), self.writeDataWithLength(2)].reversed()
        var resultPaths : [String] = []
        
        sut.enumerateContentsOfDirectory(atPath: self.directoryPath, orderedByProperty: URLResourceKey.fileSizeKey.rawValue, ascending: false) { (URL : Foundation.URL, index : Int, _) -> Void in
            resultPaths.append(URL.path)
        }
        
        XCTAssertEqual(resultPaths.count, 2)
        XCTAssertEqual(resultPaths, paths)
    }
    
    func testEnumerateContentsOfDirectoryAtPathModificationDateAscending() {
        let sut = FileManager.default
        
        let paths = [self.writeDataWithLength(1), self.writeDataWithLength(2)]
        try! sut.setAttributes([FileAttributeKey.modificationDate : Date.distantPast], ofItemAtPath: paths[0])
        
        var resultPaths : [String] = []
        
        sut.enumerateContentsOfDirectory(atPath: self.directoryPath, orderedByProperty: URLResourceKey.contentModificationDateKey.rawValue, ascending: true) { (URL : Foundation.URL, index : Int, _) -> Void in
            resultPaths.append(URL.path)
        }
        
        XCTAssertEqual(resultPaths.count, 2)
        XCTAssertEqual(resultPaths, paths)
    }
    
    func testEnumerateContentsOfDirectoryAtPathModificationDateDescending() {
        let sut = FileManager.default
        
        let paths = [self.writeDataWithLength(1), self.writeDataWithLength(2)]
        try! sut.setAttributes([FileAttributeKey.modificationDate : Date.distantPast], ofItemAtPath: paths[1])
        var resultPaths : [String] = []
        
        sut.enumerateContentsOfDirectory(atPath: self.directoryPath, orderedByProperty: URLResourceKey.contentModificationDateKey.rawValue, ascending: false) { (URL : Foundation.URL, index : Int, _) -> Void in
            resultPaths.append(URL.path)
        }
        
        XCTAssertEqual(resultPaths.count, 2)
        XCTAssertEqual(resultPaths, paths)
    }
    
}

