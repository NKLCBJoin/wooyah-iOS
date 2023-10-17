//
//  AppCoordinator.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/09/17.
//

import Foundation
import UIKit



class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator] = []
        
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.showLoginVC()
    }
    private func showLoginVC(){
        let coordinator = LoginCoordinator(navigationController: self.navigationController)
        self.childCoordinators.append(coordinator)
        coordinator.start()
    }
}
