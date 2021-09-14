//
//  ShoppingList.swift
//  ShoppingList
//
//  Created by Javid Museyibli on 12.09.21.
//

import Foundation
import Combine

class ShoppingListViewModel: ObservableObject {
    @Published var items: [ShoppingItem] = []

    var incompleteCount: Int {
        items.filter({ !$0.isCompleted }).count
    }

    func getList() {
        items = CoreDataManager.shared.getList().map(ShoppingItem.init)
    }

    func saveItem(with name: String, and dueDate: Date? = nil) {
        let item = CDShoppingItem(context: CoreDataManager.shared.viewContext)
        item.id = UUID()
        item.name = name
        item.dueDate = dueDate

        CoreDataManager.shared.saveContext()
    }

    func delete(_ shoppingItem: ShoppingItem) {
        CoreDataManager.shared.delete(shoppingItem: shoppingItem)
    }
}
