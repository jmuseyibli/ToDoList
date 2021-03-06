//
//  CompactListItem.swift
//  ShoppingList
//
//  Created by Javid Museyibli on 16.09.21.
//

import SwiftUI

struct CompactListItem: View {
    @Binding var shoppingItem: ShoppingItem
    @Binding var isCompact: Bool
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Checkbox(isChecked: $shoppingItem.isCompleted, isCompact: $isCompact)
            Text(shoppingItem.name)
                .lineLimit(1)
                .foregroundColor(shoppingItem.isCompleted ? .blue : .black)
            Spacer()
            Text(shoppingItem.dueDateDescription)
                .font(.footnote)
                .fontWeight(.light)
                .foregroundColor(.secondary)
            if shoppingItem.hasLink || shoppingItem.hasImage {
            Image(systemName: "arrow.up.left.and.arrow.down.right")
                .resizable()
                .frame(width: 12, height: 12)
                .foregroundColor(.secondary)
                .onTapGesture {
                    isCompact = false
                }
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 24)
        .onTapGesture {
            shoppingItem.isCompleted.toggle()
            CoreDataManager.shared.saveContext()
        }
    }
}
