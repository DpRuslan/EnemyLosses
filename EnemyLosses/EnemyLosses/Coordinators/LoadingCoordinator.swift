//
//  MainCoordinator.swift
//

import Foundation
import UIKit.UINavigationController
import CoreData

protocol LoadingCoordinatorProtocol: AnyObject {
    func detaiVC(id: NSManagedObjectID)
}

final class LoadingCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController?
    
    func start() {
        let vc = PageController()
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LoadingCoordinator: LoadingCoordinatorProtocol {
    func detaiVC(id: NSManagedObjectID) {
        let vc = DetailController()
        vc.viewModel.id = id
        let navigationController = UINavigationController(rootViewController: vc)
        self.navigationController?.present(navigationController, animated: true)
    }
}
