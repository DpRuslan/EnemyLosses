//
//  MainCoordinator.swift
//

import Foundation
import UIKit.UINavigationController

final class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController?
    
    func start() {
        let vc = MainController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
