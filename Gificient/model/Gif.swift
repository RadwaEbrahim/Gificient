//
//  Gif.swift
//  Gificient
//
//  Created by Radwa Ibrahim on 09.09.18.
//  Copyright © 2018 Radwa Ibrahim. All rights reserved.
//

import Foundation
typealias JSON = [String: Any]

public struct Gif: Decodable {
    let id: String
    let url: URL

    init?(gifID: String, urlString: String) {
        guard let url = URL(string: urlString) as URL? else {
            print("faild to init Gif with url: \(urlString)")
            return nil
        }
        self.url = url
        self.id = gifID
    }
    enum JSONAttributes {
        static let id = "id"
        static let images = "images"
        static let fixedHeightImage = "fixed_height"
        static let url = "url"
    }
    init?(json: JSON?) {
        guard let data = json else { return nil }
        guard let id = data[JSONAttributes.id] as? String,
            let images = data[JSONAttributes.images] as? JSON,
            let imageDict = images[JSONAttributes.fixedHeightImage] as? JSON,
            let url = imageDict[JSONAttributes.url] as? String else {
                print("faild to decode Gif with json: \(String(describing: json))")
                return nil
        }
        self.init(gifID: id, urlString: url)
    }
}
