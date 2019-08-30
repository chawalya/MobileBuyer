//
//  FeedDataDetail.swift
//  MobileBuyer
//
//  Created by Chawalya Tantisevi on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Foundation
import Alamofire
class FeedDataDetail {
   var _url = "https://scb-test-mobile.herokuapp.com/api/mobiles/%@/images/"
  
  func getData(id: String,view:UIViewController, completion: @escaping ([MobileDetailElement]) -> Void) {
    let url = String(format: _url, id)
        AF.request(URL (string:
          url)!, method: .get).responseJSON { (response) in
            switch response.result{
            case .success :
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode([MobileDetailElement].self, from: response.data!)
                    completion(result)
                } catch (let error) {
                    print(error)
                }
            case .failure(let error):
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
