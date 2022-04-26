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
        addThreeTodoTasks()
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

}

