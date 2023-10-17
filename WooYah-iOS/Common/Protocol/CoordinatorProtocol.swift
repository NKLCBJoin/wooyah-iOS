//
//  CoordinatorProtocol.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/09/17.
//

import Foundation
import UIKit

public protocol Coordinator : AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get }

    func start()
}
extension Coordinator {
  func removeChildCoordinator(child: Coordinator) {
    childCoordinators.removeAll { $0 === child }
  }
}

