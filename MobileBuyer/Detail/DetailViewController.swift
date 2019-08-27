//
//  DetailViewController.swift
//  MobileBuyer
//
//  Created by Chawalya Tantisevi on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var mobile: [MobileDetailElement]=[]
    var selected:Int = 0
    var descriptionLabel: String = ""
    var nameLabel:String = ""
    
    @IBOutlet weak var priceOutlet: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    var priceLabel: Int=0
    var ratingLabel: Int=0
    @IBOutlet var titleItem: UINavigationItem!
    @IBOutlet weak var mLabel: UILabel!
    
    var mFeed:FeedDataDetail!
    var _url:String=""
    
    @IBOutlet weak var mCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mFeed = FeedDataDetail()
        _url = "https://scb-test-mobile.herokuapp.com/api/mobiles/\(selected)/images/"
        print("page2 ===================================")
        print(_url)
        self.feedData()
        mLabel.text=descriptionLabel
        titleItem.title=nameLabel
        priceOutlet.text="Rating: \(priceLabel)"
        rateLabel.text="Price: \(ratingLabel)"
    }
    @objc func feedData(){
            self.mFeed.getData(url: _url) { (result) in
            for i in result{
                let newBean = MobileDetailElement(mobileID: i.mobileID, url: i.url, id: i.id)
                self.mobile.append(newBean)
            }
        self.mCollection.reloadData()
        print (self.mobile.count)
            
        }
    }
    

}
extension DetailViewController: UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mobile.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? DetailCollectionViewCell
        cell?.imageView123.loadImageUrl(self.mobile[indexPath.row].url)

        return cell!

    }
}

