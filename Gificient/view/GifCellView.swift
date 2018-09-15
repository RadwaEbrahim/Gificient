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
    let gifManager = SwiftyGifManager(memoryLimit:100)
    override func prepareForReuse(){
        self.gifImageView?.image = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configCell(with gif: Gif) {
        self.gifImageView.setGifFromURL(gif.url, manager: gifManager, loopCount: -1, showLoader: true)
        self.gifImageView?.delegate = self
    }

}

extension GifCellView : SwiftyGifDelegate {
    func gifURLDidFinish(sender: UIImageView) {
    print("gifURLDidFinish")
    }

    func gifURLDidFail(sender: UIImageView) {
    print("gifURLDidFail")
    }

    func gifDidStart(sender: UIImageView) {
    print("gifDidStart")
    }
}
