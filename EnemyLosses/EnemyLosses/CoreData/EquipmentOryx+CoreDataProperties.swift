//
//  EquipmentOryx+CoreDataProperties.swift
//  

import Foundation
import CoreData


extension EquipmentOryx {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EquipmentOryx> {
        return NSFetchRequest<EquipmentOryx>(entityName: "EquipmentOryx")
    }

    @NSManaged public var equipmentOryx: String?
    @NSManaged public var equipmentUA: String?
    @NSManaged public var lossesTotal: Int64
    @NSManaged public var manufacturer: String?
    @NSManaged public var model: String?

}

extension EquipmentOryx : Identifiable {

}
