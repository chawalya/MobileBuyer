//
//  FeedData.swift
//  MobileBuyer
//
//  Created by Chawalya Tantisevi on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Alamofire
import Foundation

class FeedData {
  let _url: String = "https://scb-test-mobile.herokuapp.com/api/mobiles/"
  func getData(view:UIViewController, completion: @escaping ([MobileElement]) -> Void) {
        AF.request(URL(string: _url)!, method: .get).responseJSON { response in
            switch response.result {
            case .success:
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode([MobileElement].self, from: response.data!)
                    completion(result)
                } catch let error {
                    print(error)
                }
            case let .failure(error):
              if error._code == NSURLErrorTimedOut {
                let alertVC = UIAlertController(title: "Server Not response ", message: "", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                view.present(alertVC, animated: true, completion: nil)
              }
              let alertVC = UIAlertController(title: "Network not connection", message: "", preferredStyle: .alert)
              alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
              view.present(alertVC, animated: true, completion: nil)
            }
        }
    }
}
