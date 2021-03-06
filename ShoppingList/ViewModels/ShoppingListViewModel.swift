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
    @Published var itemsByDate = [Date: [ShoppingItem]]()
    var cancellabes = Set<AnyCancellable>()

    init() {
        getList()
        $items.sink { items in
            let items = items.filter({ $0.dueDate != nil })
            self.itemsByDate = Dictionary(grouping: items, by: {Calendar.current.startOfDay(for: $0.dueDate!)})
        }.store(in: &cancellabes)
    }

    var incompleteCount: Int {
        items.filter({ !$0.isCompleted }).count
    }

    func getList() {
        items = CoreDataManager.shared.getList().map(ShoppingItem.init)
    }

    func saveItem(withIdentifier identifier: UUID, named name: String, remindedAt dueDate: Date? = nil, atLink link: String?) {
        let item = CDShoppingItem(context: CoreDataManager.shared.viewContext)
        item.id = identifier
        item.name = name
        item.dueDate = dueDate
        item.filename = identifier.uuidString.appending(".jpg")
        item.link = link
        CoreDataManager.shared.saveContext()
    }

    func delete(_ shoppingItem: ShoppingItem) {
        CoreDataManager.shared.delete(shoppingItem: shoppingItem)
    }
}
