//
//  APIModel.swift
//

import Foundation

// MARK: EquipmentResponse

struct EquipmentResponse: Decodable {
    var date: String
    var day: Int
    var aircraft: Int
    var helicopter: Int
    var tank: Int
    var APC: Int
    var fieldArtillery: Int
    var MRL: Int
    var militaryAuto: Int?
    var fuelTank: Int?
    var drone: Int
    var navalShip: Int
    var antiAircraftWarfare: Int
    var specialEquipment: Int?
    var vehiclesAndFuelTanks: Int?
    var cruiseMissiles: Int?
    var greatestLossesDirection: String?
    
    enum CodingKeys: String, CodingKey {
        case date
        case day
        case aircraft
        case helicopter
        case tank
        case APC
        case fieldArtillery = "field artillery"
        case MRL
        case militaryAuto = "military auto"
        case fuelTank = "fuel tank"
        case drone
        case navalShip = "naval ship"
        case antiAircraftWarfare = "anti-aircraft warfare"
        case specialEquipment = "special equipment"
        case vehiclesAndFuelTanks = "vehicles and fuel tanks"
        case cruiseMissiles = "cruise missiles"
        case greatestLossesDirection = "greatest losses direction"
    }
}

// MARK: EquipmentCorrectionResponse

struct EquipmentCorrectionResponse: Decodable {
    var date: String
    var day: Int
    var aircraft: Int
    var helicopter: Int
    var tank: Int
    var APC: Int
    var fieldArtillery: Int
    var MRL: Int
    var drone: Int
    var navalShip: Int
    var antiAircraftWarfare: Int
    var specialEquipment: Int?
    var vehiclesAndFuelTanks: Int?
    var cruiseMissiles: Int?
    
    enum CodingKeys: String, CodingKey {
        case date
        case day
        case aircraft
        case helicopter
        case tank
        case APC
        case fieldArtillery = "field artillery"
        case MRL
        case drone
        case navalShip = "naval ship"
        case antiAircraftWarfare = "anti-aircraft warfare"
        case specialEquipment = "special equipment"
        case vehiclesAndFuelTanks = "vehicles and fuel tanks"
        case cruiseMissiles = "cruise missiles"
    }

}

// MARK: EquipmentOryxResponse

struct EquipmentOryxResponse: Decodable {
    var equipmentOryx: String
    var model: String
    var manufacturer: String
    var lossesTotal: Int
    var equipmentUA: String
    
    enum CodingKeys: String, CodingKey {
        case equipmentOryx = "equipment_oryx"
        case model
        case manufacturer
        case lossesTotal = "losses_total"
        case equipmentUA = "equipment_ua"
    }
}

// MARK: PersonnelResponse

struct PersonnelResponse: Decodable {
    var date: String
    var day: Int
    var personnel: Int
    var personnelAbout: String
    var POW: Int
    
    enum CodingKeys: String, CodingKey {
        case date
        case day
        case personnel
        case personnelAbout = "personnel*"
        case POW
    }
}
