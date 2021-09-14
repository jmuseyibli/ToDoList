//
//  CoreDataManager.swift
//  ShoppingList
//
//  Created by Javid Museyibli on 13.09.21.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext { persistentContainer.viewContext }

    private init() {
        persistentContainer = NSPersistentContainer(name: "ShoppingList")
        persistentContainer.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

    func getList() -> [CDShoppingItem] {
        let request: NSFetchRequest<CDShoppingItem> = CDShoppingItem.fetchRequest()
        do {
            return try viewContext.fetch(request)
        } catch {
            print(error)
            return []
        }
    }

    func delete(shoppingItem: ShoppingItem) {
        viewContext.delete(shoppingItem.item)
        saveContext()
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
