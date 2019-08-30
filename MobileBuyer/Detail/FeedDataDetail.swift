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
// var _url = "https://scb-test-mobile.herokuapp.com/api/mobiles/\(selected)/images/"
    func getData(url: String, completion: @escaping ([MobileDetailElement]) -> Void) {
        AF.request(URL (string: url)!, method: .get).responseJSON { (response) in
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
                print(error)
            }
        }
        
    }
}
