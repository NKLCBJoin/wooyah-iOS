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
        let vc1 = UINavigationController(rootViewController: HomeViewController(HomeViewModel()))
        vc1.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        vc1.navigationBar.isHidden = true
        vc1.tabBarItem.image = UIImage(systemName: "house")
        let vc2 = UINavigationController(rootViewController: MapViewController(MapViewModel(usecase: MapUseCase(repository: MapRepository(mapService: MapService())))))
        vc2.tabBarItem.image = UIImage(systemName: "map")
        vc2.tabBarItem.selectedImage = UIImage(systemName: "map.fill")
        vc2.navigationBar.isHidden = true
        let vc3 = UINavigationController(rootViewController: MyPageViewController(MyPageViewModel()))
        vc3.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        vc3.tabBarItem.image = UIImage(systemName: "person")
        vc3.navigationBar.isHidden = true

   
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = .black

        self.tabBar.unselectedItemTintColor = .darkGray

        
        setViewControllers([vc1,vc2,vc3], animated: false)
    }
}
