//
//  User+CoreDataValidations.swift
//  CrudOperationCoreData
//
//  Created by Américo MQ on 26/04/22.
//

import Foundation
import CoreData

extension User {
    var errorDomain: String {
        get {
            return "User Error Domain"
        }
    }
    
    enum UserErrorType: Int {
        case InvalidUserSecondName
        case InvalidUserFirstOrSecondName
    }
    
    override public func validateForInsert() throws {
        try super.validateForInsert()
        guard let firstName = firstName else { throw NSError(domain: errorDomain, code: UserErrorType.InvalidUserFirstOrSecondName.rawValue, userInfo: [NSLocalizedDescriptionKey: "The User First Or Second Name cannot be greater tha 12 characters"]) }
        
        guard let secondName = secondName else { throw NSError(domain: errorDomain, code: UserErrorType.InvalidUserFirstOrSecondName.rawValue, userInfo: [NSLocalizedDescriptionKey: "The User First Or Second Name cannot be greater tha 12 characters"]) }
        
        if (firstName.count > 12 || secondName.count > 12) {
            throw NSError(domain: errorDomain, code: UserErrorType.InvalidUserFirstOrSecondName.rawValue, userInfo: [NSLocalizedDescriptionKey: "The User First Or Second Name cannot be greater tha 12 characters"])
        }
    }
    
    public override func validateForUpdate() throws {
        try super.validateForUpdate()
    }
    
//    public override func validateValue(_ value: AutoreleasingUnsafeMutablePointer<AnyObject?>, forKey key: String) throws {
//        if key == "secondName" {
//            var error: NSError? = nil
//
//            if let first = value.pointee as? String {
//                if first == "" {
//                    let errorType = UserErrorType.InvalidUserSecondName
//                    error = NSError(domain: errorDomain, code: errorType.rawValue, userInfo: [NSLocalizedDescriptionKey: "The User Second NAme cannot be empty"])
//                }
//                else if first.count > 12 {
//                    let errorType = UserErrorType.InvalidUserSecondName
//                    error = NSError(domain: errorDomain, code: errorType.rawValue, userInfo: [NSLocalizedDescriptionKey: "The User Second name cannot be greater than 12 character"])
//                }
//            } else {
//                let errorType = UserErrorType.InvalidUserSecondName
//                error = NSError(domain: errorDomain, code: errorType.rawValue, userInfo: [ NSLocalizedDescriptionKey: "The User Second name cannot be nil."])
//            }
//            if let error = error {
//                throw error
//            }
//        }
//    }
}
