//
//  Task+CoreDataProperties.swift
//  CrudOperationCoreData
//
//  Created by Américo MQ on 25/04/22.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var details: String?
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var ofUser: User?

}

extension Task : Identifiable {

}
