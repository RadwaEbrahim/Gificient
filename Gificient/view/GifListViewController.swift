//
//  GifListViewController.swift
//  Gificient
//
//  Created by Radwa Muhammad on 08.09.18.
//  Copyright © 2018 Radwa Ibrahim. All rights reserved.
//

import UIKit

class GifListViewController: UIViewController, GifViewModelDelegate{
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: GifViewModelProtocol?

    func loadGifsSucceeded(gifs: [Gif]) {
        self.collectionView.reloadData()
    }

    func loadGifsFailed() {
        //TODO: show alert view and hid the collectionview
    }


    override func loadView() {
        viewModel = GifViewModel(service: TrendingGifsService(), delegate: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel?.loadGifs()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension GifListViewController: UICollectionViewDelegate {

}

extension GifListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard let count = self.viewModel?.gifCount() else { return 0 }
        return count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GifCell", for: indexPath as IndexPath) as! GifCellView

        let gif = self.viewModel?.gifAtIndex(index: indexPath.row)
        cell.configCell(with: gif!)
        return cell
    }
}
