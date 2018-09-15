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

    func loadGifsSucceeded() {
        self.collectionView?.reloadData()
    }

    func loadGifsFailed() {
        //TODO: show alert view and hid the collectionview
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trending"
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel?.loadGifs()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension GifListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 400)
    }
}

extension GifListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard let count = self.viewModel?.gifCount() else { return 0 }
        return count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let _ = self.viewModel?.gifCount() else { return 0 }
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "GifCell", for: indexPath as IndexPath
            ) as! GifCellView

        guard let gif = self.viewModel?.gifAtIndex(index: indexPath.row) else {
            //FIXME: this should fail here as if viewmodel is nil at this point then something went so wrong
            return UICollectionViewCell()
        }
        cell.configCell(with: gif)
        return cell
    }
}
