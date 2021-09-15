//
//  ShoppingList.swift
//  ShoppingList
//
//  Created by Javid Museyibli on 12.09.21.
//

import Foundation
import Combine
import UIKit

class ShoppingListViewModel: ObservableObject {
    @Published var items: [ShoppingItem] = []

    var incompleteCount: Int {
        items.filter({ !$0.isCompleted }).count
    }

    func getList() {
        items = CoreDataManager.shared.getList().map(ShoppingItem.init)
    }

    func saveItem(withIdentifier identifier: UUID, named name: String, remindedAt dueDate: Date? = nil) {
        let item = CDShoppingItem(context: CoreDataManager.shared.viewContext)
        item.id = identifier
        item.name = name
        item.dueDate = dueDate
        item.filename = identifier.uuidString.appending(".jpg")
        CoreDataManager.shared.saveContext()
    }

    func delete(_ shoppingItem: ShoppingItem) {
        CoreDataManager.shared.delete(shoppingItem: shoppingItem)
    }
}
