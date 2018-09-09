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

        let task = session.dataTask(with: url) { [weak self](data, response, error) in
            guard error == nil else {
                print("error happened while calling the api: \(error!)")
                completion(nil, error)
                return
            }
            do {
                guard let gifs = try self?.gifsDecoded(from: data) else {
                    completion(nil, nil)
                    return
                }
                completion(gifs, nil)
            }
            catch {
                print("Couldn't parse the data into json with data: \(String(describing: data))")
                completion(nil, error)
                return
            }
        }
        task.resume()
    }

    func gifsDecoded(from data: Data?) throws -> Array<Gif>?  {
        var gifs: [Gif] = []

        guard let rawData = data,
        let dataDict = try JSONSerialization.jsonObject(with: rawData, options: []) as? JSON,
        let dataArray = dataDict["data"] as? [JSON] else {
            print(
                "Couldn't parse the data into json with data: \(String(describing: data))"
            )
            return nil
        }
        for json in dataArray {
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
