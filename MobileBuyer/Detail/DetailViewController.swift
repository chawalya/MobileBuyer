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
    var selected: Int = 0
    var descriptionLabel: String = ""
    var nameLabel: String = ""
    var priceLabel: Int = 0
    var ratingLabel: Int = 0
  var mobileDetail:MobileElement?
    var mFeed: FeedDataDetail!
    var _url: String = ""

    @IBOutlet var priceOutlet: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var mLabel: UILabel!
    @IBOutlet var mCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        mFeed = FeedDataDetail()
      selected = mobileDetail?.id ?? 1
      print(mobileDetail!)
      _url = "https://scb-test-mobile.herokuapp.com/api/mobiles/\(selected)/images/"
        feedData()
        mLabel.text = mobileDetail?.mobileDescription
      priceOutlet.text = "Price: \(String(describing: mobileDetail?.price))"
        rateLabel.text = "Rating: \(String(describing: mobileDetail?.rating))"
    }

    @objc func feedData() {
        mFeed.getData(url: _url) { result in
            for i in result {
                let newBean = MobileDetailElement(mobileID: i.mobileID, url: i.url, id: i.id)
                self.mobile.append(newBean)
            }
            self.mCollection.reloadData()
            print(self.mobile.count)
        }
    }
}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mobile.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? DetailCollectionViewCell
        cell?.imageView123.loadImageUrl(mobile[indexPath.row].url)
        return cell!
    }
}
