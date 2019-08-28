//
//  Data.swift
//  MobileBuyer
//
//  Created by Chawalya Tantisevi on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Foundation

// MARK: - MobileElement
struct MobileElement: Codable {
    let rating: Double
    let id: Int
    let thumbImageURL: String
    let price: Double
    let brand, name, mobileDescription: String
    
    enum CodingKeys: String, CodingKey {
        case rating, id, thumbImageURL, price, brand, name
        case mobileDescription = "description"
    }
}

typealias Mobile = [MobileElement]

import Foundation


