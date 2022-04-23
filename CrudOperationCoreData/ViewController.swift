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
        deleteTaskWithObjectOrientedWay()
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

}

