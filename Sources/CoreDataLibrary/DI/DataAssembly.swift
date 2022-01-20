//
//  File.swift
//  
//
//  Created by Edward Suwirya on 1/15/22.
//

import Foundation
import Swinject
import CoreData

public class DataAssembly: Assembly{
    public func assemble(container: Container) {
        container.register(NSManagedObjectContext.self){ _ in
            guard let modelURL = Bundle.module.url(forResource:"DatingDB", withExtension: "momd") else {  fatalError("Unresolved error")  }
            guard let model = NSManagedObjectModel(contentsOf: modelURL) else {   fatalError("Unresolved error")   }
            let dbContainer = NSPersistentContainer(name: "DatingDB",managedObjectModel: model)
            
            dbContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return dbContainer.viewContext
        }.inObjectScope(.container)
    }
}
