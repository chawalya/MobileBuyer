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
    var selectedInfo : [MobileElement] = []
    
    
    @IBAction func sortAction(_ sender: Any) {
        self.showNormalAlert()
    }
    
    let _url:String = "https://scb-test-mobile.herokuapp.com/api/mobiles/"
    var mFeed:FeedData!

    @IBOutlet weak var mTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MobileTableViewCell
        cell.listController = self
        cell.setUpButton()
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
    
    func showNormalAlert() {
        let alert = UIAlertController(title: "Sort", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Price low to high", style: .default, handler: { (_) in
            self.info.sort { (first: MobileElement, second: MobileElement) -> Bool in
                first.price < second.price
            }
            self.mTableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Price high to low", style: .default, handler: { (_) in
            self.info.sort { (first: MobileElement, second: MobileElement) -> Bool in
                first.price > second.price
            }
            self.mTableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Rating", style: .default, handler: { (_) in
            self.info.sort { (first: MobileElement, second: MobileElement) -> Bool in
                first.rating < second.rating
            }
            self.mTableView.reloadData()

        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
   
    func addCellToFavourite(cell: UITableViewCell){
        print("================================")
        let indexPathTap = mTableView.indexPath(for: cell)
        let index = indexPathTap?.row
        print(self.info[(indexPathTap?.row)!])
        selectedInfo.append(self.info[index!])
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
