//
//  CategoryType.swift
//

import Foundation

enum CategoryType: Int, CaseIterable {
    case equipment
    case equipmentCorrection
    case equipmentOryx
    case personnel
}

extension CategoryType {
    enum CellType {
        case date(value: String)
        case day(value: String)
        case aircraft(value: String)
        case helicopter(value: String)
        case tank(value: String)
        case APC(value: String)
        case fieldArtillery(value: String)
        case MRL(value: String)
        case militaryAuto(value: String)
        case fuelTank(value: String)
        case drone(value: String)
        case navalShip(value: String)
        case antiAirCraftWarfare(value: String)
        case specialEquipment(value: String)
        case vehiclesAndFuelTanks(value: String)
        case cruiseMissiles(value: String)
        case greatestLossesDirection(value: String)
        case equipmentOryx(value: String)
        case model(value: String)
        case manufacturer(value: String)
        case lossesTotal(value: String)
        case equipmentUA(value: String)
        case personnel(value: String)
        case personnelAbout(value: String)
        case POW(value: String)
    }
}

extension CategoryType.CellType {
    var title: String {
        switch self {
        case .date:
            return "Date:"
        case .day:
            return "Day:"
        case .aircraft:
            return "Aircraft:"
        case .helicopter:
            return "Helicopter:"
        case .tank:
            return "Tank:"
        case .APC:
            return "APC:"
        case .fieldArtillery:
            return "Field artillery:"
        case .MRL:
            return "MRL:"
        case .militaryAuto:
            return "Military auto:"
        case .fuelTank:
            return "Fuel tank:"
        case .drone:
            return "Drone:"
        case .navalShip:
            return "Naval ship:"
        case .antiAirCraftWarfare:
            return "Anti-aircraft warfare:"
        case .specialEquipment:
            return "Special equipment:"
        case .vehiclesAndFuelTanks:
            return "Vehicles and fuel tanks:"
        case .cruiseMissiles:
            return "Cruise missiles:"
        case .greatestLossesDirection:
            return "Greatest losses direction:"
        case .equipmentOryx:
            return "Equipment Oryx:"
        case .model:
            return "Model:"
        case .manufacturer:
            return "Manufacturer:"
        case .lossesTotal:
            return "Losses total:"
        case .equipmentUA:
            return "Equipment UA:"
        case .personnel:
            return "Personnel:"
        case .personnelAbout:
            return "Personnel about:"
        case .POW:
            return "POW:"
        }
    }
    
    var value: String {
        switch self {
        case .date(let value):
            return value
        case .day(let value):
            return value
        case .aircraft(let value):
            return value
        case .helicopter(let value):
            return value
        case .tank(let value):
            return value
        case .APC(let value):
            return value
        case .fieldArtillery(let value):
            return value
        case .MRL(let value):
            return value
        case .militaryAuto(let value):
            return value
        case .fuelTank(let value):
            return value
        case .drone(let value):
            return value
        case .navalShip(let value):
            return value
        case .antiAirCraftWarfare(let value):
            return value
        case .specialEquipment(let value):
            return value
        case .vehiclesAndFuelTanks(let value):
            return value
        case .cruiseMissiles(let value):
            return value
        case .greatestLossesDirection(let value):
            return value
        case .equipmentOryx(let value):
            return value
        case .model(let value):
            return value
        case .manufacturer(let value):
            return value
        case .lossesTotal(let value):
            return value
        case .equipmentUA(let value):
            return value
        case .personnel(let value):
            return value
        case .personnelAbout(let value):
            return value
        case .POW(let value):
            return value
        }
    }
}
//
//extension CategoryType {
//    var cellTypes: [CellType] {
//        switch self {
//        case .equipment:
//            return [.date, .day, .aircraft, .helicopter, .tank, .APC, .fieldArtillery, .MRL, .fuelTank, .drone, .navalShip, .antiAirCraftWarfare, .specialEquipment, .vehiclesAndFuelTanks, .cruiseMissiles, .greatestLossesDirection]
//        case .equipmentCorrection:
//            return [.date, .day, .aircraft, .helicopter, .tank, .APC, .fieldArtillery, .MRL, .drone, .navalShip, .antiAirCraftWarfare, .specialEquipment, .vehiclesAndFuelTanks, .cruiseMissiles]
//        case .equipmentOryx:
//            return [.equipmentOryx, .model, .manufacturer, .lossesTotal, .equipmentUA]
//        case .personnel:
//            return [.date, .day, .personnel, .personnelAbout, .POW]
//        }
//    }
//}
