//
//  MobileTableViewCell.swift
//  MobileBuyer
//
//  Created by Chawalya Tantisevi on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit

class MobileTableViewCell: UITableViewCell {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var imageView123: UIImageView!
    @IBOutlet weak var buttonOutlet: UIButton!
    var mWhenTap:Bool!
    var mImageStar:UIImage!
    var listController : ListViewController?
    
    func setUpButton(){
        buttonOutlet.addTarget(self, action: #selector(handleMarkFavorite), for: .touchUpInside)
        self.mWhenTap = true
    }
    
    @objc
    func handleMarkFavorite(){
        if mWhenTap {
            mImageStar  = UIImage(named: "star-tap.png")!
            buttonOutlet.setImage(mImageStar, for: .normal)
            self.mWhenTap = false
          print("11111111")
        }else{
            mImageStar  = UIImage(named: "star.png")!
            buttonOutlet.setImage(mImageStar, for: .normal)
            self.mWhenTap = true
          print("2222222")
        }
        listController?.addCellToFavourite(cell : self)
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
