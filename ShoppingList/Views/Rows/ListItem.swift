//
//  ListItem.swift
//  ShoppingList
//
//  Created by Javid Museyibli on 13.09.21.
//

import SwiftUI

struct ListItem: View {
    @Binding var shoppingItem: ShoppingItem

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Checkbox(isChecked: $shoppingItem.isCompleted)
            Text(shoppingItem.name)
                .foregroundColor(shoppingItem.isCompleted ? .blue : .black)
            Spacer()
            Text(shoppingItem.dueDate?.description ?? "")
                .font(.footnote)
                .fontWeight(.light)
                .foregroundColor(.secondary)
            

        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .onTapGesture {
            shoppingItem.isCompleted.toggle()
            CoreDataManager.shared.saveContext()
        }
    }
}

struct ListItem_Previews: PreviewProvider {
    static let cdItem: CDShoppingItem = {
        let cdItem = CDShoppingItem(context: CoreDataManager.shared.viewContext)
        cdItem.id = UUID()
        cdItem.name = "Sample row"
        cdItem.dueDate = Date()
        return cdItem
    }()

    static var previews: some View {
        ListItem(shoppingItem: .constant(ShoppingItem(item: cdItem))).previewLayout(.fixed(width: 375, height: 64))
    }
}
