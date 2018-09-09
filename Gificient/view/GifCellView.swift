//
//  GifCellView.swift
//  Gificient
//
//  Created by Radwa Ibrahim on 09.09.18.
//  Copyright © 2018 Radwa Ibrahim. All rights reserved.
//

import UIKit
import SwiftyGif

class GifCellView : UICollectionViewCell {
    @IBOutlet weak var gifImageView: UIImageView!

    func configCell(with gif: Gif) {
        self.gifImageView.setGifFromURL(gif.url)
    }
}
