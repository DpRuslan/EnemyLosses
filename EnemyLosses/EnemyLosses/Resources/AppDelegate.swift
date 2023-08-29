//
//  AppDelegate.swift
//  

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var navVC: UINavigationController?
    var coordinator: MainCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if checkForEmptyCoreData() {
            requests()
        } else {
            dataIsReady()
        }
        return true
    }
    
    
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    static var coreDataStack = CoreDataStack(modelName: "EnemyLosses")
}

extension AppDelegate {
    func dataIsReady() {
        window = UIWindow(frame: UIScreen.main.bounds)
        navVC = UINavigationController()
        coordinator = MainCoordinator()
        coordinator!.navigationController = navVC
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        coordinator!.start()
    }
}

// MARK: Making requests

extension AppDelegate {
    func requests() {
        var equipments: [EquipmentResponse] = []
        var personnels: [PersonnelResponse] = []
        var equipmentsOryx: [EquipmentOryxResponse] = []
        var equipmentsCorrection: [EquipmentCorrectionResponse] = []
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        APIManager.shared.request(endpoint: .equipmentEndPoint, method: .GET) { result in
            defer {
                dispatchGroup.leave()
            }
            
            switch result {
            case .success(let data):
                do {
                    equipments = try JSONDecoder().decode([EquipmentResponse].self, from: data)
                } catch {
                    print("Error decoding - \(error)")
                }
            case .failure(let error):
                print("Error - \(error.localizedDescription)")
            }
        }
        
        dispatchGroup.enter()
        APIManager.shared.request(endpoint: .personnelEndPoint, method: .GET) { result in
            defer {
                dispatchGroup.leave()
            }
            
            switch result {
            case .success(let data):
                do {
                    personnels = try JSONDecoder().decode([PersonnelResponse].self, from: data)
                } catch {
                    print("Error decoding - \(error)")
                }
            case .failure(let error):
                print("Error - \(error.localizedDescription)")
            }
        }
        
        dispatchGroup.enter()
        APIManager.shared.request(endpoint: .equipmentOryxEndPoint, method: .GET) { result in
            defer {
                dispatchGroup.leave()
            }
            
            switch result {
            case .success(let data):
                do {
                    equipmentsOryx = try JSONDecoder().decode([EquipmentOryxResponse].self, from: data)
                } catch {
                    print("Error decoding - \(error)")
                }
            case .failure(let error):
                print("Error - \(error.localizedDescription)")
            }
        }
        
        dispatchGroup.enter()
        APIManager.shared.request(endpoint: .equipmentCorrectionEndPoint, method: .GET) { result in
            defer {
                dispatchGroup.leave()
            }
            
            switch result {
            case .success(let data):
                do {
                    equipmentsCorrection = try JSONDecoder().decode([EquipmentCorrectionResponse].self, from: data)
                } catch {
                    print("Error decoding - \(error)")
                }
            case .failure(let error):
                print("Error - \(error.localizedDescription)")
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.saveToCoreData(equipments: equipments, personnels: personnels, equipmentsCorrection: equipmentsCorrection, equipmentsOryx: equipmentsOryx)
            self.dataIsReady()
        }
    }
}

// MARK: Check if CoreData is empty

extension AppDelegate {
    func checkForEmptyCoreData() -> Bool {
        let managedContext = AppDelegate.coreDataStack.managedContext
        do {
            if try managedContext.count(for: NSFetchRequest<Equipment>(entityName: "Equipment")) == 0 {
                return true
            } else {
                return false
            }
        } catch let error as NSError {
            print("error - \(error.localizedDescription)")
        }
        
        return false
    }
    
    // MARK: Save to CoreData
    
    func saveToCoreData(equipments: [EquipmentResponse], personnels: [PersonnelResponse], equipmentsCorrection: [EquipmentCorrectionResponse], equipmentsOryx: [EquipmentOryxResponse]) {
        let managedContext = AppDelegate.coreDataStack.managedContext
        for i in equipments {
            let newEquipment = Equipment(context: managedContext)
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
        
        for i in personnels {
            let newPersonnel = Personnel(context: managedContext)
            
            newPersonnel.date = i.date
            newPersonnel.day = Int64(i.day)
            newPersonnel.personnel = Int64(i.personnel)
            newPersonnel.personnelAbout = i.personnelAbout
            assignIfNotNil(i.POW.map(Int64.init), to: &newPersonnel.pow)
        }
        
        for i in equipmentsOryx {
            let newEquipmentOryx = EquipmentOryx(context: managedContext)
            
            newEquipmentOryx.equipmentOryx = i.equipmentOryx
            newEquipmentOryx.model = i.model
            newEquipmentOryx.manufacturer = i.manufacturer
            newEquipmentOryx.lossesTotal = Int64(i.lossesTotal)
            newEquipmentOryx.equipmentUA = i.equipmentOryx
        }
        
        for i in equipmentsCorrection {
            let newEquipmentCorrection = EquipmentCorrection(context: managedContext)
            
            newEquipmentCorrection.date = i.date
            newEquipmentCorrection.day = Int64(i.day)
            newEquipmentCorrection.aircraft = Int64(i.aircraft)
            newEquipmentCorrection.helicopter = Int64(i.helicopter)
            newEquipmentCorrection.tank = Int64(i.tank)
            newEquipmentCorrection.apc = Int64(i.APC)
            newEquipmentCorrection.fieldArtillery = Int64(i.fieldArtillery)
            newEquipmentCorrection.mrl = Int64(i.MRL)
            newEquipmentCorrection.drone = Int64(i.drone)
            newEquipmentCorrection.navalShip = Int64(i.navalShip)
            newEquipmentCorrection.antiAircraftWarfare = Int64(i.antiAircraftWarfare)
            newEquipmentCorrection.specialEquipment = Int64(i.specialEquipment)
            newEquipmentCorrection.vehiclesAndFuelTanks = Int64(i.vehiclesAndFuelTanks)
            newEquipmentCorrection.cruiseMissiles = Int64(i.cruiseMissiles)
        }
        
        AppDelegate.coreDataStack.saveContext()
    }
    
    func assignIfNotNil<T>(_ value: T?, to property: inout T) {
        if let value = value {
            property = value
        }
    }
}






