//
//  MainViewModel.swift
//  

import Foundation
import CoreData

final class MainViewModel: NSObject, NSFetchedResultsControllerDelegate {
    lazy var fetchedResultController = makeFetchedResultsController()
    
    override init() {
        super.init()
        
        do {
            try fetchedResultController.performFetch()
        } catch {
            print("Fetch error: \(error)")
        }
    }
    func makeFetchedResultsController() -> NSFetchedResultsController<Equipment> {
        let request: NSFetchRequest<Equipment> = Equipment.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(key: "day", ascending: true)]
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: AppDelegate.coreDataStack.managedContext, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        return controller
    }
}

extension MainViewModel {
    func numberOfItems() -> Int {
        fetchedResultController.fetchedObjects?.count ?? 0
    }
    
    func itemAt(at index: Int) -> Equipment? {
        guard let equipment = fetchedResultController.fetchedObjects?[index] else {
            return nil
        }
        return equipment
    }
}

extension MainViewModel {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) { }
}
