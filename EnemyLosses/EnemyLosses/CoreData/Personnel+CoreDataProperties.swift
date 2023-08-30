//
//  Personnel+CoreDataProperties.swift
//  

import Foundation
import CoreData


extension Personnel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Personnel> {
        return NSFetchRequest<Personnel>(entityName: "Personnel")
    }

    @NSManaged public var date: String?
    @NSManaged public var day: Int64
    @NSManaged public var personnel: Int64
    @NSManaged public var personnelAbout: String?
    @NSManaged public var pow: Int64

}

extension Personnel : Identifiable {

}
