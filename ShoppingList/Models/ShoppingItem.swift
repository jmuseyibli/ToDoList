//
//  ShoppingItem.swift
//  ShoppingList
//
//  Created by Javid Museyibli on 13.09.21.
//

import Foundation
import UIKit

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

    var link: String? {
        item.link
    }

    var hasLink: Bool {
        if let link = link {
            return !link.isEmpty
        }
        return false
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

    static func photoURL(filename: String?) -> URL? {
        guard let filename = filename else { return nil }
        let applicationDocumentsDirectory: URL = {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0]
        }()
        return applicationDocumentsDirectory.appendingPathComponent(filename)
    }

    var image: UIImage? {
        guard let path = ShoppingItem.photoURL(filename: item.filename)?.path else { return nil }
        return UIImage(contentsOfFile: path)
    }

    var hasImage: Bool {
        if let image = image {
            return !image.isEmpty
        }
        return false
    }


}
