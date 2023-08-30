//
//  PersonnelViewModel.swift
//

import Foundation
import CoreData
import UIKit.UITableViewCell

final class PersonnelViewModel: ViewModelProtocol {
    weak var coordinator: LoadingCoordinatorProtocol?
    typealias EntityType = Personnel
    lazy var fetchedResultController = makeFetchedResultsController()
    var sortDescriptors: [NSSortDescriptor]? {
        return [NSSortDescriptor(key: "date", ascending: true)]
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
