//
//  MainViewModel.swift
//  

import Foundation
import CoreData

final class MainViewModel {
    var fetchedResultController: NSFetchedResultsController<Equipment>?
    
    func equipmnentRequest() {
        APIManager.shared.request(endpoint: .equipmentEndPoint, method: .GET) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let equipments = try decoder.decode([EquipmentResponse].self, from: data)
                    self?.checkOrSaveToCoreData(items: equipments)
                } catch {
                    print("Error decoding - \(error)")
                }
                
            case .failure(let error) :
                print("Error - \(error.localizedDescription)")
            }
        }
    }
    
    func checkOrSaveToCoreData(items: [EquipmentResponse]) {
        do {
            if try AppDelegate.coreDataStack.managedContext.count(for: NSFetchRequest<Equipment>(entityName: "Equipment")) == 0 {
                for i in items {
                    let newEquipment = Equipment(context: AppDelegate.coreDataStack.managedContext)
                    
                    newEquipment.date = i.date
                    newEquipment.day = Int64(i.day)
                    newEquipment.aircraft = Int64(i.aircraft)
                    newEquipment.helicopter = Int64(i.helicopter)
                    newEquipment.tank = Int64(i.tank)
                    newEquipment.apc = Int64(i.APC)
                    newEquipment.fieldArtillery = Int64(i.fieldArtillery)
                    newEquipment.mrl = Int64(i.MRL)
                    assignIfNotNil(i.militaryAuto.map(Int64.init), to: &newEquipment.militaryAuto)
                    assignIfNotNil(i.fuelTank.map(Int64.init), to: &newEquipment.fuelTank)
                    newEquipment.drone = Int64(i.drone)
                    newEquipment.navalShip = Int64(i.navalShip)
                    newEquipment.antiAircraftWarfare = Int64(i.antiAircraftWarfare)
                    assignIfNotNil(i.specialEquipment.map(Int64.init), to: &newEquipment.specialEquipment)
                    assignIfNotNil(i.vehiclesAndFuelTanks.map(Int64.init), to: &newEquipment.vehiclesAndFuelTanks)
                    assignIfNotNil(i.cruiseMissiles.map(Int64.init), to: &newEquipment.cruiseMissiles)
                    assignIfNotNil(i.greatestLossesDirection, to: &newEquipment.greatestLossesDirection)
                }
                
                AppDelegate.coreDataStack.saveContext()
            } else {
                fetchedResultController = makeFetchedResultsController()
            }
            
        } catch let error as NSError {
            print("error - \(error.localizedDescription)")
        }
    }
    
    func assignIfNotNil<T>(_ value: T?, to property: inout T) {
        if let value = value {
            property = value
        }
    }
    
    func makeFetchedResultsController() -> NSFetchedResultsController<Equipment> {
        let request: NSFetchRequest<Equipment> = Equipment.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(key: "day", ascending: true)]
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: AppDelegate.coreDataStack.managedContext, sectionNameKeyPath: nil, cacheName: nil)
        return controller
    }
}

extension MainViewModel {
    func numberOfItems() -> Int {
        fetchedResultController?.fetchedObjects?.count ?? 0
    }
    
    func itemAt(at index: Int) -> Equipment? {
        guard let equipment = fetchedResultController?.fetchedObjects?[index] else {
            return nil
        }
        return equipment
    }
}
