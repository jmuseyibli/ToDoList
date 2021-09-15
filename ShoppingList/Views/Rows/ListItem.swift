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
        HStack(alignment: .center, spacing: 8) {
            if let image = shoppingItem.photoImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 44, height: 44)
                    .clipped()
                    .cornerRadius(8)
            }
            Text(shoppingItem.name)
                .foregroundColor(shoppingItem.isCompleted ? .blue : .black)
            Spacer()
            Text(shoppingItem.dueDateDescription)
                .font(.footnote)
                .fontWeight(.light)
                .foregroundColor(.secondary)
            Checkbox(isChecked: $shoppingItem.isCompleted)
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 24)
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
        cdItem.filename = "name.jpg"
        cdItem.dueDate = Date()
        return cdItem
    }()

    static var previews: some View {
        ListItem(shoppingItem: .constant(ShoppingItem(item: cdItem))).previewLayout(.fixed(width: 375, height: 64))
    }
}
