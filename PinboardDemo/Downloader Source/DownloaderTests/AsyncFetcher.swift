//
//  AsyncFetcher.swift
//  PinboardDemo
//
//  Created by SYED FARAN GHANI on 21/09/19.
//  Copyright © 2019 Syed Faran Ghani. All rights reserved.
//

import Foundation
@testable import Downloader

class AsyncFetcher<T : DataConvertible> : Fetcher<T> {

    let getValue : () -> T.Result

    init(key: String, value getValue : @autoclosure @escaping () -> T.Result) {
        self.getValue = getValue
        super.init(key: key)
    }

    override func fetch(failure fail: @escaping ((Error?) -> ()), success succeed: @escaping (T.Result) -> ()) {
        let value = getValue()
        DispatchQueue.global(qos: .default).async {
            DispatchQueue.main.async {
                succeed(value)
            }
        }
    }

    override func cancelFetch() {}

}
