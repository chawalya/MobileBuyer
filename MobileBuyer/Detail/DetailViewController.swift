//
//  DetailViewController.swift
//  MobileBuyer
//
//  Created by Chawalya Tantisevi on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var mobile: [MobileDetailElement] = []
    var mobileDetail: MobileElement?
    var mFeed: FeedDataDetail!
    @IBOutlet var priceOutlet: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var mLabel: UILabel!
    @IBOutlet var mCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        mFeed = FeedDataDetail()
        feedData()
        mLabel.text = mobileDetail?.mobileDescription
      priceOutlet.text = "Price: \(mobileDetail?.price ?? 0)"
        rateLabel.text = "Rating: \(mobileDetail?.rating ?? 0)"
    }

    @objc func feedData() {
        if let id = mobileDetail?.id{
      mFeed.getData(id: String(id),view: self) { result in
            for i in result {
                let newBean = MobileDetailElement(mobileID: i.mobileID, url: i.url, id: i.id)
                self.mobile.append(newBean)
            }
            self.mCollection.reloadData()
            print(self.mobile.count)
        }
    }
      
  }
}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mobile.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? DetailCollectionViewCell
        cell?.imageViewDatail.loadImageUrl(mobile[indexPath.row].url)
        return cell!
    }
}
