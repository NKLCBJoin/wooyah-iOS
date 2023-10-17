//
//  HomeCoordinator.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/09/17.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator{
    var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = HomeViewController()
        self.navigationController.viewControllers = [vc]
    }
    func removeCoordinator(){
        parentCoordinator?.removeChildCoordinator(child: self)
    }
}
