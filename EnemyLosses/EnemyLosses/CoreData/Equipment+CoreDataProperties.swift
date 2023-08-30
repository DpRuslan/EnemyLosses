//
//  Equipment+CoreDataProperties.swift
//  

import Foundation
import CoreData


extension Equipment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Equipment> {
        return NSFetchRequest<Equipment>(entityName: "Equipment")
    }

    @NSManaged public var aircraft: Int64
    @NSManaged public var antiAircraftWarfare: Int64
    @NSManaged public var apc: Int64
    @NSManaged public var cruiseMissiles: Int64
    @NSManaged public var date: String?
    @NSManaged public var day: Int64
    @NSManaged public var drone: Int64
    @NSManaged public var fieldArtillery: Int64
    @NSManaged public var fuelTank: Int64
    @NSManaged public var greatestLossesDirection: String?
    @NSManaged public var helicopter: Int64
    @NSManaged public var militaryAuto: Int64
    @NSManaged public var mrl: Int64
    @NSManaged public var navalShip: Int64
    @NSManaged public var specialEquipment: Int64
    @NSManaged public var tank: Int64
    @NSManaged public var vehiclesAndFuelTanks: Int64

}

extension Equipment : Identifiable {

}
