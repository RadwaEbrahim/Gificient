//
//  TradingGifsServiceTest.swift
//  GificientTests
//
//  Created by Radwa Ibrahim on 09.09.18.
//  Copyright © 2018 Radwa Ibrahim. All rights reserved.
//

import XCTest
@testable import Gificient

class TradingGifsServiceTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGifsDecoded() {
        let data = """
        {
            "data": [
                {
                    "id": "xxx",
                    "images": {
                        "fixed_height": {
                            "url": "xxx"
                        }
                    }
                },
                {
                    "id": "zzz",
                    "images": {
                        "fixed_height": {
                            "url": "xxx"
                        }
                    }
                }
            ]
        }
        """.data(using: .utf8)!
        let service = TrendingGifsService()
        XCTAssertNoThrow(try service.gifsDecoded(from: data)) 
    }
    
}
