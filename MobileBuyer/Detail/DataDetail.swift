//
//  DataDetail.swift
//  MobileBuyer
//
//  Created by Chawalya Tantisevi on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//
import Foundation

// MARK: - MobileDetailElement
struct MobileDetailElement: Codable {
    let mobileID: Int
    let url: String
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case mobileID = "mobile_id"
        case url, id
    }
}

typealias MobileDetail = [MobileDetailElement]


