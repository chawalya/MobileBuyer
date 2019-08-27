//
//  FirstViewController.swift
//  MobileBuyer
//
//  Created by Chawalya Tantisevi on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit
import AlamofireImage

class ListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var info:[MobileElement] = []
    var isSelect:Int = 0
    var rating:Int=0
    var price:Int=0
    var name:String = ""
    var strDescription:String = ""
    let _url:String = "https://scb-test-mobile.herokuapp.com/api/mobiles/"
    var mFeed:FeedData!

    @IBOutlet weak var mTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MobileTableViewCell
        cell.nameLabel.text = self.info[indexPath.row].name
        cell.priceLabel.text = "Price: \(self.info[indexPath.row].price)"
        cell.ratingLabel.text = "Rating: \(self.info[indexPath.row].rating)"
        cell.imageView123.loadImageUrl(self.info[indexPath.row].thumbImageURL)
        cell.descriptionLabel.text = self.info[indexPath.row].mobileDescription
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        isSelect=info[indexPath.row].id
        strDescription=info[indexPath.row].mobileDescription
        name=info[indexPath.row].name
        rating=Int(info[indexPath.row].rating)
        price=Int(info[indexPath.row].price)
        self.performSegue(withIdentifier: "showDetail", sender: info[indexPath.row])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mFeed=FeedData()
        self.feedData()

    }
    @objc func feedData(){
        self.info.removeAll()//clear data support not dup data
        self.mFeed.getData(url: _url) { (result) in
            for i in result{
                let newBean = MobileElement(rating: i.rating, id: i.id, thumbImageURL: i.thumbImageURL, price: i.price, brand: i.brand, name: i.name, mobileDescription: i.mobileDescription)
                self.info.append(newBean)
            }
            self.mTableView.reloadData()
            print (self.info.count)
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail",
            let viewController = segue.destination as? DetailViewController {
            viewController.selected = isSelect
            viewController.descriptionLabel = strDescription
            viewController.nameLabel = name
            viewController.priceLabel = price
            viewController.ratingLabel = rating
        }
    }
}
    
extension UIImageView{
    func loadImageUrl(_ urlString:String){
        self.af_setImage(withURL: URL(string: urlString)!)
    }
}
