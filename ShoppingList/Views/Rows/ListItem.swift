//
//  ListItem.swift
//  ShoppingList
//
//  Created by Javid Museyibli on 13.09.21.
//

import SwiftUI
import Combine

struct ListItem: View {
    @Binding var shoppingItem: ShoppingItem
    @State private var isCompact = true

    var body: some View {
        if isCompact {
            CompactListItem(shoppingItem: $shoppingItem, isCompact: $isCompact)
        } else {
            LargeListItem(shoppingItem: $shoppingItem, isCompact: $isCompact)
        }
    }
}


struct ListItem_Previews: PreviewProvider {
    static let cdItem: CDShoppingItem = {
        let cdItem = CDShoppingItem(context: CoreDataManager.shared.viewContext)
        cdItem.id = UUID()
        cdItem.name = "Sample row might be long"
        cdItem.filename = "name.jpg"
        cdItem.dueDate = Date()
        cdItem.link = "Salam"
        return cdItem
    }()

    static var previews: some View {
        ListItem(shoppingItem: .constant(ShoppingItem(item: cdItem))).previewLayout(.fixed(width: 375, height: 164))
    }
}
