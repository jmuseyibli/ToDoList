//
//  LargeListItem.swift
//  ShoppingList
//
//  Created by Javid Museyibli on 16.09.21.
//

import SwiftUI

struct LargeListItem: View {
    @Binding var shoppingItem: ShoppingItem
    @Binding var isCompact: Bool
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 4) {
                Spacer()
                Checkbox(isChecked: $shoppingItem.isCompleted, isCompact: $isCompact)
                Text(shoppingItem.isCompleted ? "Completed" : "Incomplete")
                    .foregroundColor(shoppingItem.isCompleted ? .blue : .secondary)
            }
            if let image = shoppingItem.photoImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .cornerRadius(8)
            }
            Text(shoppingItem.name)
                .foregroundColor(shoppingItem.isCompleted ? .blue : .black)
            HStack(spacing: 4) {
                if shoppingItem.hasLink {
                    Image(systemName: "link")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundColor(.blue)
                    Text(shoppingItem.link ?? "")
                        .foregroundColor(.blue)
                        .fontWeight(.medium)
                }
                Spacer()
                Image(systemName: "arrow.down.right.and.arrow.up.left")
                    .resizable()
                    .frame(width: 12, height: 12)
                    .foregroundColor(.primary)
                    .onTapGesture {
                        isCompact = true
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
