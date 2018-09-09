//
//  GifTests.swift
//  GificientTests
//
//  Created by Radwa Ibrahim on 09.09.18.
//  Copyright © 2018 Radwa Ibrahim. All rights reserved.
//

import XCTest
@testable import Gificient

class GifTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit() {
        let id = "xxxx"
        let urlString = "www.xxx.com"
        let gif = Gif(gifID: id, urlString: urlString)
        XCTAssertEqual(gif?.id, id)
        XCTAssertEqual(gif?.url.absoluteString, urlString)
    }

    func testInitFailWithBadURL() {
        let id = "xxxx"
        let urlString = ""
        let gif = Gif(gifID: id, urlString: urlString)
        XCTAssertNil(gif)
    }
    
    func testDecodeFailWithWrongJson(){
        let json = """
        {
            "id": "xxx",
            "images": {
                "fixed_height": {
                }
            }
        }
        """.data(using: .utf8)!

        XCTAssertThrowsError(try JSONDecoder().decode(Gif.self, from: json))
    }

    func testDecodeWithCorrectJson(){
        let json: JSON =
        [
            "id": "xxx",
            "images": [
                "fixed_height": [
                    "url" : "xxx"
                ]
            ]
        ]
        let gif = Gif(json: json)
        XCTAssertEqual(gif?.id, "xxx")
        XCTAssertEqual(gif?.url.absoluteString, "xxx")
    }
    
}
