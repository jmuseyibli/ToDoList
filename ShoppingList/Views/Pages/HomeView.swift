//
//  HomeView.swift
//  ShoppingList
//
//  Created by Javid Museyibli on 14.09.21.
//

import SwiftUI

struct HomeView: View {

    var body: some View {

        TabView {
            ListView().tabItem { Label("List", systemImage: "list.dash") }
            CalendarView().tabItem { Label("Calendar", systemImage: "calendar") }
        }
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct ListView: View {
    @State var presentingCreateView = false
    @ObservedObject var viewModel = ShoppingListViewModel()

    var body: some View {
        NavigationView {
            List() {
                Text("You have \(viewModel.incompleteCount) uncompleted items in your shopping list")
                    .font(.footnote)
                    .foregroundColor(.gray)
                ForEach(viewModel.items) { item in
                    let matchedIndex = viewModel.items.firstIndex { $0.id == item.id }
                    ListItem(shoppingItem: $viewModel.items[matchedIndex!])
                        .listRowInsets(EdgeInsets())
                }.onDelete(perform: { indexSet in
                    indexSet.forEach { index in
                        let shoppingItem = viewModel.items[index]
                        viewModel.delete(shoppingItem)
                        viewModel.getList()
                    }
                })
            }
            .listStyle(PlainListStyle())
            .padding(.top, 12)
            .navigationTitle("Shopping List")
            .navigationBarItems(
                trailing: Button("Create") {
                    self.presentingCreateView = true
                }
                .sheet(isPresented: $presentingCreateView) {
                    CreateView(viewModel: viewModel)
                }
            )
        }
    }
}
