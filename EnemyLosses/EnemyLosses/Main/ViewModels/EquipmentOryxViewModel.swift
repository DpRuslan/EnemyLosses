//
//  EquipmentOryxViewModel.swift
//

import Foundation
import CoreData
import UIKit.UITableViewCell

final class EquipmentOryxViewModel: ViewModelProtocol {
    weak var coordinator: LoadingCoordinatorProtocol?
    typealias EntityType = EquipmentOryx
    lazy var fetchedResultController = makeFetchedResultsController()
    var sortDescriptors: [NSSortDescriptor]? {
        return [NSSortDescriptor(key: "model", ascending: true)]
    }
    
    var nameKeyPath: String? {
        "equipmentOryx"
    }
    
    init(coordinator: LoadingCoordinatorProtocol) {
        self.coordinator = coordinator
        do {
            try fetchedResultController.performFetch()
        } catch {
            print("Fetch error: \(error)")
        }
    }
    
    func fetchedResultsController() -> NSFetchedResultsController<EntityType> {
        fetchedResultController
    }
}
