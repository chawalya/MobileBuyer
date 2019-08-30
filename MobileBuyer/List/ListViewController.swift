//
//  FirstViewController.swift
//  MobileBuyer
//
//  Created by Chawalya Tantisevi on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import AlamofireImage
import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var mobileList: [MobileElement] = []
//    var temp: [MobileElement] = []
    var notFav: MobileElement?
    var arrayFav: [Int] = []
    var isSelect: Int = 0
    var rating: Int = 0
    var price: Int = 0
  var chkfirst = true
  var mobileIsFav: [MobileElement]=[]

  
  
    var selectedIndex = 0
  
    var name: String = ""
    var isHidden2 = false
    
    var mFeed: FeedData!
    var strDescription: String = ""
    var isFavMode = false
  

    @IBOutlet var mTableView: UITableView!

    @IBAction func allAction(_ sender: Any) {
        isFavMode = false
        isHidden2 = false
        mTableView.reloadData()
    }

    @IBAction func Favourite(_ sender: Any) {
       isFavMode = true
        isHidden2 = true
        mTableView.reloadData()
    }

    @IBAction func sortAction(_ sender: Any) {
        showNormalAlert()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      if !isFavMode {
        return mobileList.count
      } else {
        var countFav = 0
        for i in mobileList{
          if i.isFav{
            countFav+=1
          }
        }
        return countFav
      }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MobileTableViewCell
      if !isFavMode{
        cell.listController = self
        cell.setUpButton()
        cell.buttonOutlet.isHidden = false
//        cell.buttonOutlet.addTarget(self, action: #selector(handleMarkFavorite), for: .touchUpInside)
        cell.index = indexPath.row
        cell.nameLabel.text = mobileList[indexPath.row].name
        cell.priceLabel.text = "Price: \(mobileList[indexPath.row].price)"
        cell.ratingLabel.text = "Rating: \(mobileList[indexPath.row].rating)"
        cell.imageView123.loadImageUrl(mobileList[indexPath.row].thumbImageURL)
        cell.descriptionLabel.text = mobileList[indexPath.row].mobileDescription
        cell.updateFav( isFav: mobileList[indexPath.row].isFav)
        
      } else {
        mobileIsFav.removeAll()
        for i in mobileList{
          if i.isFav {
            print(i)
            mobileIsFav.append(i)
            print(mobileIsFav)
          }
        }
        
        cell.buttonOutlet.isHidden = true
        cell.listController = self
        cell.setUpButton()
        cell.buttonOutlet.isHidden = isHidden2
        //        cell.buttonOutlet.addTarget(self, action: #selector(handleMarkFavorite), for: .touchUpInside)
        cell.index = indexPath.row
        cell.nameLabel.text = mobileIsFav[indexPath.row].name
        cell.priceLabel.text = "Price: \(mobileIsFav[indexPath.row].price)"
        cell.ratingLabel.text = "Rating: \(mobileIsFav[indexPath.row].rating)"
        cell.imageView123.loadImageUrl(mobileIsFav[indexPath.row].thumbImageURL)
        cell.descriptionLabel.text = mobileIsFav[indexPath.row].mobileDescription
        cell.updateFav( isFav: mobileList[indexPath.row].isFav)
      }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndex = indexPath.row
      print(indexPath.row)
//      performSegue(withIdentifier: "showDetail", sender: mobileList[selectedIndex])

      if isFavMode{
         performSegue(withIdentifier: "showDetail", sender: mobileIsFav[selectedIndex])
      } else {
         performSegue(withIdentifier: "showDetail", sender: mobileList[selectedIndex])
      }
      
//        isSelect = mobileList[indexPath.row].id
//        strDescription = mobileList[indexPath.row].mobileDescription
//        name = mobileList[indexPath.row].name
//        rating = Int(mobileList[indexPath.row].rating)
//        price = Int(mobileList[indexPath.row].price)
      
    }

    func showNormalAlert() {
        let alert = UIAlertController(title: "Sort", message: "", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Price low to high", style: .default, handler: { _ in
            self.mobileList.sort { (first: MobileElement, second: MobileElement) -> Bool in
                first.price < second.price
            }
            self.mTableView.reloadData()
        }))

        alert.addAction(UIAlertAction(title: "Price high to low", style: .default, handler: { _ in
            self.mobileList.sort { (first: MobileElement, second: MobileElement) -> Bool in
                first.price > second.price
            }
            self.mTableView.reloadData()
        }))

        alert.addAction(UIAlertAction(title: "Rating", style: .default, handler: { _ in
            self.mobileList.sort { (first: MobileElement, second: MobileElement) -> Bool in
                first.rating < second.rating
            }
            self.mTableView.reloadData()

        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }

    func addCellToFavourite() {
      DispatchQueue.main.async {
        self.mTableView.reloadData()
      }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        mFeed = FeedData()
        feedData()
    }

    @objc func feedData() {
      mFeed.getData(view:self) { result in
            for i in result {
                let newBean = MobileElement(rating: i.rating, id: i.id, thumbImageURL: i.thumbImageURL, price: i.price, brand: i.brand, name: i.name, mobileDescription: i.mobileDescription, isFav: i.isFav)
                self.mobileList.append(newBean)
//                self.temp = self.mobileList
            }

            self.mTableView.reloadData()
//            print(self.mobileList.count)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail",
            let viewController = segue.destination as? DetailViewController {
          print(selectedIndex)
          print(mobileIsFav)
         
//           viewController.mobileDetail = mobileIsFav[selectedIndex]
          if !isFavMode{
            viewController.mobileDetail = mobileList[selectedIndex]
          } else {
            viewController.mobileDetail = mobileIsFav[selectedIndex]
          }
          
//            viewController.selected = isSelect
//            viewController.descriptionLabel = strDescription
//            viewController.nameLabel = name
//            viewController.priceLabel = price
//            viewController.ratingLabel = rating
        }
    }
}

extension UIImageView {
    func loadImageUrl(_ urlString: String) {
        af_setImage(withURL: URL(string: urlString)!)
    }
}
