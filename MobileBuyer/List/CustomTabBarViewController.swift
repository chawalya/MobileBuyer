//
//  CustomTabBarViewController.swift
//  MobileBuyer
//
//  Created by Chawalya Tantisevi on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit

class CustomTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillLayoutSubviews() {
        tabBar.frame = CGRect(x: 0, y: 75, width: tabBar.frame.size.width, height: tabBar.frame.size.height)
    }
    
}
