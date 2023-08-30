//
//  ViewModelProtocol.swift
//  

import Foundation
import CoreData
import UIKit.UITableViewCell

protocol ViewModelProtocol {
    associatedtype EntityType: NSManagedObject
    var sortDescriptors: [NSSortDescriptor]? { get }
    var coordinator: LoadingCoordinatorProtocol? { get }
    var nameKeyPath: String? { get }
    func makeFetchedResultsController() -> NSFetchedResultsController<EntityType>
    func numberOfItems() -> Int
    func fetchedResultsController() -> NSFetchedResultsController<EntityType>
    func itemAt(at index: Int) -> EntityType?
    func didSelectAt(at index: Int)
}

extension ViewModelProtocol {
    func makeFetchedResultsController() -> NSFetchedResultsController<EntityType> {
        let request = EntityType.fetchRequest() as! NSFetchRequest<EntityType>
        
        request.sortDescriptors = sortDescriptors
        let controller = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: AppDelegate.coreDataStack.managedContext,
            sectionNameKeyPath: nameKeyPath ?? nil,
            cacheName: nil
        )
        
        return controller
    }
    
    var nameKeyPath: String? {
        nil
    }
    
    func numberOfItems() -> Int {
        fetchedResultsController().fetchedObjects?.count ?? 0
    }
    
    func itemAt(at index: Int) -> EntityType? {
        guard let item = fetchedResultsController().fetchedObjects?[index] else {
            return nil
        }
        return item
    }
    
    func didSelectAt(at index: Int) {
        coordinator?.detaiVC(id: itemAt(at: index)!.objectID)
    }
}
