//
//  TabBarController.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/09/17.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hexString: "#FBFCFC")
        self.delegate = self
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        vc1.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        vc1.navigationBar.isHidden = true
        vc1.tabBarItem.image = UIImage(systemName: "house")
    }
}
