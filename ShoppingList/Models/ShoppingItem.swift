//
//  ShoppingItem.swift
//  ShoppingList
//
//  Created by Javid Museyibli on 13.09.21.
//

import Foundation

struct ShoppingItem: Identifiable {
    let item: CDShoppingItem

    var id: UUID {
        item.id ?? UUID()
    }

    var name: String {
        item.name ?? ""
    }

    var dueDate: Date? {
        item.dueDate
    }

    var dueDateDescription: String {
        if let date = dueDate {
            let formatter = RelativeDateTimeFormatter()
            return formatter.localizedString(for: date, relativeTo: Date())
        }
        return ""
    }

    var isCompleted: Bool {
        get { item.isCompleted }
        set {
            item.isCompleted = newValue
            CoreDataManager.shared.saveContext()
        }
    }
}
