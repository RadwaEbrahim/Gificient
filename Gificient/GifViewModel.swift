//
//  GifViewModel.swift
//  Gificient
//
//  Created by Radwa Ibrahim on 09.09.18.
//  Copyright © 2018 Radwa Ibrahim. All rights reserved.
//

import Foundation

protocol GifViewModelProtocol {
    var apiService: APIService {get}
    var delegate: GifViewModelDelegate? {get set}

    func loadGifs()
    func gifAtIndex(index: Int) -> Gif
    func gifCount() -> Int

}
protocol GifViewModelDelegate {
    func loadGifsSucceeded()
    func loadGifsFailed()
}

class GifViewModel: GifViewModelProtocol {
    let apiService: APIService

    let urlString = "https://api.giphy.com/v1/gifs/trending?api_key=RxXE7cwVqUvgySqzOdogkiOZ6l5NDk8c&limit=25&rating=G"
    var gifList: [Gif] = []
    var delegate: GifViewModelDelegate?

    init(service: APIService = TrendingGifsService(), delegate: GifViewModelDelegate? = nil) {
        self.apiService = service
        self.delegate = delegate
    }

    func loadGifs() {
        self.apiService.request(urlString: urlString) { gifs, error in
            guard let gifs = gifs, error == nil else {
                self.delegate?.loadGifsFailed()
                return
            }
            self.gifList = gifs
            DispatchQueue.main.async{
                self.delegate?.loadGifsSucceeded()
            }
        }
    }

    func gifAtIndex(index: Int) -> Gif {
        return self.gifList[index]
    }

    func gifCount() -> Int {
        return self.gifList.count
    }
}
