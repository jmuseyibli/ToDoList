//
//  HomeView.swift
//  ShoppingList
//
//  Created by Javid Museyibli on 14.09.21.
//

import SwiftUI

struct HomeView: View {
    @State private var items = (0...5).map { id -> ShoppingItem in
        let cdItem = CDShoppingItem(context: CoreDataManager.shared.viewContext)
        cdItem.id = UUID()
        cdItem.name = "Sample row"
        cdItem.dueDate = Date()
        return ShoppingItem(item: cdItem)
    }

    var body: some View {
        NavigationView {
            List() {
                ForEach(items) { item in
                    let matchedIndex = items.firstIndex { $0.id == item.id }
                    ListItem(shoppingItem: $items[matchedIndex!]).listRowInsets(EdgeInsets())
                }
            }
            .listStyle(PlainListStyle())
            .padding(.top, 12)
            .navigationTitle("Shopping List")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
