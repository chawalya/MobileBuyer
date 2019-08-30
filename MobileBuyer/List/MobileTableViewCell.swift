//
//  MobileTableViewCell.swift
//  MobileBuyer
//
//  Created by Chawalya Tantisevi on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit

class MobileTableViewCell: UITableViewCell {
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var imageView123: UIImageView!
    @IBOutlet var buttonOutlet: UIButton!
    var isHidden2: Bool?
    var index: Int?
    var isFavorited: Bool = false
    var mImageStar: UIImage!
    var listController: ListViewController?

    func setUpButton() {
        buttonOutlet.addTarget(self, action: #selector(handleMarkFavorite), for: .touchUpInside)
    }

    @objc
    func handleMarkFavorite() {
        if isFavorited { // isFav
            isFavorited = false
            listController?.mobileList[index!].isFav = false

        } else {
            isFavorited = true
            listController?.mobileList[index!].isFav = true

        }
        listController?.addCellToFavourite()
    }
  
  func updateFav(isFav: Bool){
      if isFav { // isFav
        mImageStar = UIImage(named: "star-tap.png")!
        buttonOutlet.setImage(mImageStar, for: .normal)
      } else {
        mImageStar = UIImage(named: "star.png")!
        buttonOutlet.setImage(mImageStar, for: .normal)
    }
  }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
