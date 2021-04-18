//
//  File.swift
//  Media_final_project
//
//  Created by TTN on 18/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import CoreData

struct  CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Final_Project_App")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of store failed \(error)")
            }
            
        }
         return container
    }()
   
    func createUserDetails(firstName: String, lastName: String, username: String, password: String) -> User? {
        
        let context = persistentContainer.viewContext
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! User
        user.firstname = firstName
        user.lastname = lastName
        user.username = username
        user.password = password
        
        do {
            try context.save()
            return user
        } catch let createError {
            print("failed to create: \(createError)")
        }
        return nil
    }
    
    func fetchUserDetails() -> [User]? {
        
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        
        do {
            let details = try context.fetch(fetchRequest)
            return details
        } catch let fetchError {
            print("Failed to fetch: \(fetchError)")
        }
        return nil
    }
    
    
    func fetchUserDetails(withUserName username: String) -> User? {
        
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "email == %@", username)
        
        do {
            let details = try context.fetch(fetchRequest)
            return details.first
        } catch let fetchError {
            print("Failed to fetch User details: \(fetchError)")
        }
        return nil
    }
    
    func deleteUserDetails(userdetails: User){
        
        let context = persistentContainer.viewContext
        context.delete(userdetails)
        
        do {
            try context.save()
        } catch let saveError {
            print ("Failed to delete: \(saveError)")
        }
    }
}
