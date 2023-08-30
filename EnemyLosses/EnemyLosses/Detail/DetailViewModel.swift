//
//  DetailViewModel.swift
//  

import Foundation
import CoreData

final class DetailViewModel {
    var id: NSManagedObjectID?
    var categoryType: CategoryType?
    var dataSource: [CategoryType.CellType] = []
    
    func findCategoryType() {
        let managedObject = try! AppDelegate.coreDataStack.managedContext.existingObject(with: id!)
        switch  managedObject {
        case let equipment as Equipment:
            categoryType = .equipment
            dataSource = [
                .date(value: equipment.date ?? "None"),
                .day(value: "\(equipment.day)"),
                .aircraft(value: "\(equipment.aircraft)"),
                .helicopter(value: "\(equipment.helicopter)"),
                .tank(value: "\(equipment.tank)"),
                .APC(value: "\(equipment.apc)"),
                .fieldArtillery(value: "\(equipment.fieldArtillery)"),
                .MRL(value: "\(equipment.mrl)"),
                .militaryAuto(value: "\(equipment.militaryAuto)"),
                .fuelTank(value: "\(equipment.fuelTank)"),
                .drone(value: "\(equipment.drone)"),
                .navalShip(value: "\(equipment.navalShip)"),
                .antiAirCraftWarfare(value: "\(equipment.antiAircraftWarfare)"),
                .specialEquipment(value: "\(equipment.specialEquipment)"),
                .vehiclesAndFuelTanks(value: "\(equipment.vehiclesAndFuelTanks)"),
                .cruiseMissiles(value: "\(equipment.cruiseMissiles)"),
                .greatestLossesDirection(value: equipment.greatestLossesDirection ?? "None")
            ]
        case let equipmentOryx as EquipmentOryx:
            categoryType = .equipmentOryx
            dataSource = [
                .equipmentOryx(value: equipmentOryx.equipmentOryx ?? "None"),
                .model(value: equipmentOryx.model ?? "None"),
                .manufacturer(value: equipmentOryx.manufacturer ?? "None"),
                .equipmentUA(value: equipmentOryx.equipmentUA ?? "None")
            ]
            
        case let equipmentCorrection as EquipmentCorrection:
            categoryType = .equipmentCorrection
            dataSource = [
                .date(value: equipmentCorrection.date ?? "None"),
                .day(value: "\(equipmentCorrection.day)"),
                .aircraft(value: "\(equipmentCorrection.aircraft)"),
                .helicopter(value: "\(equipmentCorrection.helicopter)"),
                .tank(value: "\(equipmentCorrection.tank)"),
                .APC(value: "\(equipmentCorrection.apc)"),
                .fieldArtillery(value: "\(equipmentCorrection.fieldArtillery)"),
                .MRL(value: "\(equipmentCorrection.mrl)"),
                .drone(value: "\(equipmentCorrection.drone)"),
                .navalShip(value: "\(equipmentCorrection.navalShip)"),
                .antiAirCraftWarfare(value: "\(equipmentCorrection.antiAircraftWarfare)"),
                .specialEquipment(value: "\(equipmentCorrection.specialEquipment)"),
                .vehiclesAndFuelTanks(value: "\(equipmentCorrection.vehiclesAndFuelTanks)"),
                .cruiseMissiles(value: "\(equipmentCorrection.cruiseMissiles)")
            ]
            
        case let personnel as Personnel:
            categoryType = .personnel
            dataSource = [
                .date(value: personnel.date ?? "None"),
                .day(value: "\(personnel.day)"),
                .personnel(value: "\(personnel.personnel)"),
                .personnelAbout(value: personnel.personnelAbout ?? "None"),
                .POW(value: "\(personnel.pow)")
            ]
            
        default:
            break
        }
    }
    
    func numberOfItems() -> Int {
        dataSource.count
    }
    
    func itemValueAt(at index: Int) -> String {
        dataSource[index].value
    }
    
    func itemTitleAt(at index: Int) -> String {
        dataSource[index].title
    }
}
