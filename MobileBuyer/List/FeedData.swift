//
//  FeedData.swift
//  MobileBuyer
//
//  Created by Chawalya Tantisevi on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Foundation
import Alamofire

class FeedData {
    func getData(url: String, completion: @escaping ([MobileElement]) -> Void) {
        AF.request(URL (string: url)!, method: .get).responseJSON { (response) in
            switch response.result{
            case .success :
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode([MobileElement].self, from: response.data!)
                    completion(result)
                    print("success------------------------------")
                } catch (let error) {
                    print(error)
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
        
    }
}
