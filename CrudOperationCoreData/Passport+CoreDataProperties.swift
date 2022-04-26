//
//  Passport+CoreDataProperties.swift
//  CrudOperationCoreData
//
//  Created by Américo MQ on 25/04/22.
//
//

import Foundation
import CoreData


extension Passport {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Passport> {
        return NSFetchRequest<Passport>(entityName: "Passport")
    }

    @NSManaged public var expiryDate: Date?
    @NSManaged public var number: String?
    @NSManaged public var ofUser: User?

}

extension Passport : Identifiable {

}
