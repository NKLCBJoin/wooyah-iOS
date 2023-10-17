//
//  LoginCoordinator.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/09/17.
//

import Foundation
import UIKit


final class LoginCoordinator : Coordinator {
    var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = LoginViewController()
        self.navigationController.viewControllers = [vc]
    }
    func showHomeVC(){
        let coordinator = HomeCoordinator(navigationController: self.navigationController)
        self.childCoordinators.append(coordinator)
        coordinator.start()
    }
}

