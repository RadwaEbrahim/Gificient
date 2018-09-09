//
//  TrendingGifsService.swift
//  Gificient
//
//  Created by Radwa Ibrahim on 09.09.18.
//  Copyright © 2018 Radwa Ibrahim. All rights reserved.
//

import Foundation

typealias RequestCompletionHandler = (_ gifs: Array<Gif>?,_ error: Error?) -> Void
protocol APIService {
    func request(urlString: String, completion: @escaping RequestCompletionHandler)

}

class TrendingGifsService: APIService {
    func request(urlString: String, completion: @escaping RequestCompletionHandler) {

        let url = URL(string: urlString)!
        let session = URLSession(configuration: URLSessionConfiguration.default)

        let _ = session.dataTask(with: url) { [weak self](data, response, error) in
            guard error == nil else {
                print("error happened while calling the api: \(error!)")
                completion(nil, error)
                return
            }
            do {
                guard let responseData = data,
                    let jsonArray = try JSONSerialization.jsonObject(
                        with: responseData, options: []) as? [JSON] else {
                            print(
                                "Couldn't parse the data into json with data: \(String(describing: data))"
                            )
                            completion(nil, error)
                            return
                }
                let gifs = self?.gifsDecoded(from: jsonArray)
                completion(gifs, nil)
            }
            catch {
                print("Couldn't parse the data into json with data: \(String(describing: data))")
                completion(nil, error)
                return
            }
        }

    }

    func gifsDecoded(from jsonArray: [JSON]) -> Array<Gif>? {
        var gifs: [Gif] = []
        for json in jsonArray {
            guard let gif = Gif(json: json) else {
                print(
                    "Couldn't parse the json into gif with json:\(String(describing: json))"
                )
                return nil
            }
            gifs.append(gif)
        }
        return gifs
    }
}
