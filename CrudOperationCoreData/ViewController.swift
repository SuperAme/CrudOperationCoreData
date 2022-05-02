//
//  ViewController.swift
//  CrudOperationCoreData
//
//  Created by Américo MQ on 19/04/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
//        addToDoTask()
//        fetchTaskFromCoreData()
//        deleteTaskFromCoreData()
//        addTododTaskWithObjectOrientedWay()
//        fetchTaskWithObjectOrientedWay()
//        deleteTaskWithObjectOrientedWay()
//        addTodoTaskWithEntityHavingRelationshipWithOtherEntityObjectOrientedWay()
//        fetchTaskFromCoreDataWithObjectEntityHavingRelationshipWithOtherEntityOrientedWay()
//        deleteTaskFromCoreDataWithObjectEntityHavingRelationshipWithOtherEntity()
//        addUser()
//        addThreeTodoTasks()
//        addTwoUsers()
//        fetchUserFromCoreDataWithPredicate()
//        addThreeUsers()
//        fetchUserFromCoreDataWithSortDescriptor()
//        fetchRequestResultTypeManagedObject()
//        fetchRequestResultTypeDictionary()
//        fetchRequestResultCount()
//        fetchRequestResultObjectId()
//        fetchRequestFaulObjects()
//        propertiesToFetch()
//        fetchLimit()
//        insertTenThousandsUserObject()
//        fetchUsingBatchWithLimitAndOffset()
//        addTwoUsersPart11()
//        notificationInsertFired()
        notificationUpdateFired()
    }

    func addToDoTask() {
        //get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need context from container Entity needs context to create in this managedObjectContext
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //We create a entity object Task is our entity and we are creating in this managedObjectContext
        let todoEntity = NSEntityDescription.entity(forEntityName: "Task", in: managedObjectContext)!
        
        //Adding Records in TODO List
        let todo = NSManagedObject(entity: todoEntity, insertInto: managedObjectContext)
        
        todo.setValue("First Item", forKey: "name")
        todo.setValue("First Item Description", forKey: "details")
        todo.setValue(1, forKey: "id")
        
        //Save to persisten store
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchTaskFromCoreData() {
        //get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need context from container Entity needs context to create in this managedObjectContext
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //Create fetch Request
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Task")
        
        do {
            let tasks = try managedObjectContext.fetch(fetchRequest)
            
            for data in tasks {
                print(data.value(forKey: "details") ?? "No data found")
            }
        } catch let error as NSError {
            print("Could not fetch. \(error)")
        }
        
    }
    
    func deleteTaskFromCoreData() {
        //get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need context from container Entity needs context to create in this managedObjectContext
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //Create fetch Request
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Task")
        
        do {
            let tasks = try managedObjectContext.fetch(fetchRequest)
            
            for data in tasks {
                managedObjectContext.delete(data)
            }
            
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                print("Could not save, \(error)")
            }
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
    }
    
    func addTododTaskWithObjectOrientedWay() {
        //get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need context from container Entity needs context to create in this managedObjectContext
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //Create a TodoList object
        let todoObject = Task(context: managedObjectContext)
        todoObject.name = "Fisrt Item"
        todoObject.details = "First Item Description"
        todoObject.id = 1
        
        //Save to persistent Store
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("could not save \(error)")
        }
    }
    
    func fetchTaskWithObjectOrientedWay() {
        //get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need context from container Entity needs context to create in this managedObjectContext
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //Create fetch Request
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        
        do {
            let tasks = try managedObjectContext.fetch(fetchRequest)
            
            for data in tasks {
                print(data.details ?? "No data found")
            }
        } catch let error as NSError {
            print("Could not fetch. \(error)")
        }
    }
    
    func deleteTaskWithObjectOrientedWay() {
        //get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need context from container Entity needs context to create in this managedObjectContext
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //Create fetch Request
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Task")
        
        do {
            let tasks = try managedObjectContext.fetch(fetchRequest)
            
            for task in tasks {
                managedObjectContext.delete(task)
            }
            
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                print("Could not save, \(error)")
            }
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }

    }
    
    func addTodoTaskWithEntityHavingRelationshipWithOtherEntityObjectOrientedWay() {
        //get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need context from container Entity needs context to create in this managedObjectContext
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //Create a first todo object
        let todoObjectOne = Task(context: managedObjectContext)
        todoObjectOne.name = "First item"
        todoObjectOne.details = "First item Description"
        todoObjectOne.id = 1
        
        //Create a second todo object
        let todoObjectSecond = Task(context: managedObjectContext)
        todoObjectSecond.name = "Second item"
        todoObjectSecond.details = "Second item Description"
        todoObjectSecond.id = 1
        
        //Create a User Passport object
        let userPassport = Passport(context: managedObjectContext)
        userPassport.expiryDate = Date()
        userPassport.number = "User Passport number"
        
        //Create a user object
        let user = User(context: managedObjectContext)
        user.firstName = "User First name"
        user.secondName = "User second name"
        user.userId = 123
        
        //Asign tasks to user
        user.tasks = NSSet.init(array: [todoObjectOne,todoObjectSecond])
        
        //Asign passport to user objects
        user.passport = userPassport
        
        //Save to persistent store
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save \(error)")
        }
    }
    
    func fetchTaskFromCoreDataWithObjectEntityHavingRelationshipWithOtherEntityOrientedWay() {
        //get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need context from container Entity needs context to create in this managedObjectContext
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //create fecth request
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        
        do {
            let tasks = try managedObjectContext.fetch(fetchRequest)
            
            for task in tasks {
                print(task.details ?? "No data found")
                
                print(task.ofUser?.firstName ?? "No user first name")
                
                print(task.ofUser?.passport?.number ?? "No user Passport")
            }
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
    }
    
    func deleteTaskFromCoreDataWithObjectEntityHavingRelationshipWithOtherEntity() {
        //get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need context from container Entity needs context to create in this managedObjectContext
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //create fetch request
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        
        do {
            let users = try managedObjectContext.fetch(fetchRequest)
            
            for user in users {
                managedObjectContext.delete(user)
            }
            
            //fetch task
            let fetchRequestTask = NSFetchRequest<NSManagedObject>(entityName: "Task")
            let tasks = try? managedObjectContext.fetch(fetchRequestTask)
            print("task count \(String(describing: tasks?.count))")
            
            //fetch passport
            let fetchRequestPassport = NSFetchRequest<NSManagedObject>(entityName: "Passport")
            let passports = try? managedObjectContext.fetch(fetchRequestPassport)
            print("passports count \(String(describing: passports?.count))")
            
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                print("Could not save \(error)")
            }
            
            
            
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
    }
    
    func addUser() {
        //get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need context from container Entity needs context to create in this managedObjectContext
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //Create a User Object
        let user = User(context: managedObjectContext)
        user.secondName = "User Second Name"
        
        print("User First Name \(String(describing: user.firstName))")
        user.userId = 123
        user.firstName = "This contains more than 12 characters"
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save \(error)")
        }
    }
    
    func addThreeTodoTasks() {
        //get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need context from container Entity needs context to create in this managedObjectContext
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //Create a first todo object
//        let todoObjectOne = Task(context: managedObjectContext)
//        todoObjectOne.name = "First item"
//        todoObjectOne.details = "First item Description"
//        todoObjectOne.id = 1
        
        //Create a second todo object
//        let todoObjectSecond = Task(context: managedObjectContext)
//        todoObjectSecond.name = "Second item"
//        todoObjectSecond.details = "Second item Description"
//        todoObjectSecond.id = 2
        
        //Create a third todo object
//        let todoObjectThird = Task(context: managedObjectContext)
//        todoObjectThird.name = "Third item"
//        todoObjectThird.details = "Third item Description"
//        todoObjectThird.id = 3
        
        //Create a User object
        let user = User(context: managedObjectContext)
        user.firstName = "first name of the user"
        user.secondName = "Second"
        user.userId = 123
        
//        user.tasks = NSSet.init(array: [todoObjectOne,todoObjectSecond,todoObjectThird])
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save \(error)")
        }
    }
    
    func addTwoUsers() {
        //get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need context from container Entity needs context to create in this managedObjectContext
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //Create Users object
        
        let user = User(context: managedObjectContext)
        user.secondName = "User one Second Name"
        user.firstName = "Ali"
        
        let secondUser = User(context: managedObjectContext)
        secondUser.secondName = "User Two Second Name"
        secondUser.firstName = "Not Ali"
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save \(error)")
        }
    }
    
    func fetchUserFromCoreDataWithPredicate() {
        //get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need context from container Entity needs context to create in this managedObjectContext
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //Create fetch request
        let userFetchRequest = NSFetchRequest<User>(entityName: "User")
        
        //Filter using predicate
        userFetchRequest.predicate = NSPredicate(format: "firstName == %@", "Ali")
        
        do {
            let users = try managedObjectContext.fetch(userFetchRequest)
            print("Users Count \(users.count)")
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
    }
    
    func addThreeUsers() {
        //get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need context from container Entity needs context to create in this managedObjectContext
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //Create Users object
        
        let user = User(context: managedObjectContext)
        user.secondName = "Vijay"
        user.firstName = "Kumar"
        
        let secondUser = User(context: managedObjectContext)
        secondUser.secondName = "Subhan"
        secondUser.firstName = "Ali"
        
        let thirdUSer = User(context: managedObjectContext)
        thirdUSer.secondName = "Akhtar"
        thirdUSer.firstName = "Ali"
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save \(error)")
        }
    }
    
    func fetchUserFromCoreDataWithSortDescriptor() {
        //get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need context from container Entity needs context to create in this managedObjectContext
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //Create fetch request
        let userFetchRequest = NSFetchRequest<User>(entityName: "User")
        
        //Add two sort descriptors
        let sortByFirstName = NSSortDescriptor.init(key: "firstName", ascending: true)
        let sortBySecondName = NSSortDescriptor.init(key: "secondName", ascending: true)
        
        //filter using predicate
        userFetchRequest.sortDescriptors = [sortByFirstName,sortBySecondName]
        
        do {
            let users = try managedObjectContext.fetch(userFetchRequest)
            
            for user in users {
                print("User First Name \(String(describing: user.firstName ?? "Default Value"))")
                print("User Second Name \(String(describing: user.secondName ?? "Default Value"))")
                print("\n\n\n")
            }
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
    }
    
    func fetchRequestResultTypeManagedObject() {
        //get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need context from container Entity needs context to create in this managedObjectContext
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //Create fetch request
        let userFetchRequest = NSFetchRequest<User>(entityName: "User")
        
        //Define result type
        userFetchRequest.resultType = .managedObjectResultType
        
        do {
            let users: [User] = try managedObjectContext.fetch(userFetchRequest)
            
            for user in users {
                let firstName = user.firstName
                print("Object return \(user)")
            }
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
    }
    
    func fetchRequestResultTypeDictionary() {
        //get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need context from container Entity needs context to create in this managedObjectContext
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //Create fetch request
        let userFetchRequest = NSFetchRequest<NSDictionary>(entityName: "User")
        
        //Define result type
        userFetchRequest.resultType = .dictionaryResultType
        
        do {
            let users: [NSDictionary] = try managedObjectContext.fetch(userFetchRequest)
            
            for user in users {
                print("User First Name \(String(describing: user["firstName"] ?? "Default Value"))")
                print("User Second Name \(String(describing: user["secondName"] ?? "Default Value"))")
                print("\n\n\n")
            }
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
    }
    
    func fetchRequestResultCount() {
        //get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need context from container Entity needs context to create in this managedObjectContext
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //Create fetch request
        let userFetchRequest = NSFetchRequest<NSNumber>(entityName: "User")
        
        //Define result type
        userFetchRequest.resultType = .countResultType
        
        do {
            let counts: [NSNumber] = try managedObjectContext.fetch(userFetchRequest)
            
            for count in counts {
                print(count)
                print("\n\n\n")
            }
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
    }
    
    func fetchRequestResultObjectId() {
        //get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need context from container Entity needs context to create in this managedObjectContext
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //Create fetch request
        let userFetchRequest = NSFetchRequest<NSManagedObjectID>(entityName: "User")
        
        //Define result type
        userFetchRequest.resultType = .managedObjectIDResultType
        
        do {
            let objectIds: [NSManagedObjectID] = try managedObjectContext.fetch(userFetchRequest)
            
            for objectId in objectIds {
                print(objectId)
                print("\n\n\n")
            }
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
    }
    
    func fetchRequestFaulObjects() {
        //get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need context from container Entity needs context to create in this managedObjectContext
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //Create fetch request
        let userFetchRequest = NSFetchRequest<User>(entityName: "User")
        
        //Define result type
        userFetchRequest.returnsObjectsAsFaults = true
        
        do {
            //Execute fetch request
            let users: [User] = try managedObjectContext.fetch(userFetchRequest)
            print("Printing Faul Data")
            //print before fault fired
            for user in users {
                print("Object return \(user)")
            }
            //access any one property to fire fault
            for user in users {
                _ = user.firstName
            }
            print("\n\n\n\n\n Printing after fired fault")
            //print after fault fired
            for user in users {
                print("Object return \(user)")
            }
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
    }
    
    func propertiesToFetch() {
        //get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need context from container Entity needs context to create in this managedObjectContext
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //Create fetch request
        let userFetchRequest = NSFetchRequest<NSDictionary>(entityName: "User")
        
        userFetchRequest.propertiesToFetch = ["firstName"]
        userFetchRequest.resultType = .dictionaryResultType
        
        do {
            let users: [NSDictionary] = try managedObjectContext.fetch(userFetchRequest)
            
            for user in users {
                print("Object Return \(user)")
            }
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
    }
    
    func fetchLimit() {
        //get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need context from container Entity needs context to create in this managedObjectContext
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //Create fetch request
        let userFetchRequest = NSFetchRequest<User>(entityName: "User")
        
        userFetchRequest.fetchLimit = 2
        userFetchRequest.returnsObjectsAsFaults = false
        
        do {
            let users: [User] = try managedObjectContext.fetch(userFetchRequest)
            
            for user in users {
                print("Object Return \(user)")
            }
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
    }
    
    func insertTenThousandsUserObject() {
        //get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need context from container Entity needs context to create in this managedObjectContext
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        for i in 0..<10000 {
            let user = User(context: managedObjectContext)
            user.secondName = "Second Name \(i)"
            user.userId = Int64(i)
            user.firstName = "First Name \(i)"
        }
        
        do {
            let startTime = CFAbsoluteTimeGetCurrent()
            try managedObjectContext.save()
            print("Saving the thousands of objects time \(CFAbsoluteTimeGetCurrent() - startTime)")
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
    }
    
    func fetchUsingBatchWithLimitAndOffset() {
        //get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need context from container Entity needs context to create in this managedObjectContext
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //Create fetch Request
        let userFetchRequest = NSFetchRequest<User>(entityName: "User")
        var fetchOffSet = 0
        userFetchRequest.fetchOffset = fetchOffSet
        userFetchRequest.fetchLimit = 1000
        
        do {
            var users: [User] = try managedObjectContext.fetch(userFetchRequest)
            print("Users count \(users.count)")
            
            while users.count > 0 {
                fetchOffSet = fetchOffSet + users.count
                userFetchRequest.fetchOffset = fetchOffSet
                users = try managedObjectContext.fetch(userFetchRequest)
                
                print("Users count \(users.count)")
            }
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
    }
    
    func addTwoUsersPart11() {
        //get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need context from container Entity needs context to create in this managedObjectContext
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let userFetchRequest = NSFetchRequest<User>(entityName: "User")
        
        DispatchQueue.global(qos: .background).async {
            print("Background thread")
            print("Executing Background thread")
            
            print("\(Thread.current)\n\n")
            
            managedObjectContext.perform {
                print("\(Thread.current)\n\n")
                print("Switched Main Thread")
                
                //Create Users object
                
                let user = User(context: managedObjectContext)
                user.secondName = "User one Second Name"
                user.firstName = "Ali"
                
                let secondUser = User(context: managedObjectContext)
                secondUser.secondName = "User Two Second Name"
                secondUser.firstName = "Not Ali"
                
                do {
                    try managedObjectContext.save()
                } catch let error as NSError {
                    print("Could not save \(error)")
                }
            }
        }
        
    }
    
    func notificationInsertFired() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need context from container Entity needs context to create in this managedObjectContext
        let mainQueueContext = appDelegate.persistentContainer.viewContext
        
        NotificationCenter.default.addObserver(self, selector: #selector(contextObjectsDidChange(_:)), name: Notification.Name.NSManagedObjectContextObjectsDidChange, object: mainQueueContext)
        
        NotificationCenter.default.addObserver(self, selector: #selector(contextWillSave(_:)), name: Notification.Name.NSManagedObjectContextWillSave, object: mainQueueContext)
        
        NotificationCenter.default.addObserver(self, selector: #selector(contextDidSave(_:)), name: Notification.Name.NSManagedObjectContextDidSave, object: mainQueueContext)
        
        mainQueueContext.performAndWait {
            let newUser = User(context: mainQueueContext)
            newUser.secondName = "user One Second Name"
            newUser.firstName = "ali"
            
            do {
                try mainQueueContext.save()
            } catch let error as NSError {
                print("Could not save \(error)")
            }
        }
    }
    
    func notificationUpdateFired() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need context from container Entity needs context to create in this managedObjectContext
        let mainQueueContext = appDelegate.persistentContainer.viewContext
        
        NotificationCenter.default.addObserver(self, selector: #selector(contextObjectsDidChange(_:)), name: Notification.Name.NSManagedObjectContextObjectsDidChange, object: mainQueueContext)
        
        NotificationCenter.default.addObserver(self, selector: #selector(contextWillSave(_:)), name: Notification.Name.NSManagedObjectContextWillSave, object: mainQueueContext)
        
        NotificationCenter.default.addObserver(self, selector: #selector(contextDidSave(_:)), name: Notification.Name.NSManagedObjectContextDidSave, object: mainQueueContext)
        
        let userFetchRequest = NSFetchRequest<User>(entityName: "User")
        mainQueueContext.performAndWait {
            let usersOfMainContext: [User] = try! mainQueueContext.fetch(userFetchRequest)
            usersOfMainContext[0].secondName = "Updated User One Second Name"
            usersOfMainContext[0].firstName = "Updated ali"
            
            do {
                try mainQueueContext.save()
            } catch let error as NSError {
                print("Could not save \(error)")
            }
        }
    }
    
    @objc func contextObjectsDidChange(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        
        if let inserts = userInfo[NSInsertedObjectsKey] as? Set<NSManagedObject>, inserts.count > 0 {
            print("--- INSERTS ---")
            print(inserts)
            print("+++++++++++++++")
        }
        
        if let updates = userInfo[NSUpdatedObjectsKey] as? Set<NSManagedObject>, updates.count > 0 {
            print("--- Updates ---")
            for update in updates {
                print(update.changedValues())
            }
            print("+++++++++++++++")
        }
        
        if let deletes = userInfo[NSDeletedObjectsKey] as? Set<NSManagedObject>, deletes.count > 0 {
            print("--- DELETES ---")
            print(deletes)
            print("+++++++++++++++")
        }
    }
    
    @objc func contextWillSave(_ notification: Notification) {
        
    }
    
    @objc func contextDidSave(_ notification: Notification) {
        
    }

}

