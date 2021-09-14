//
//  CreateView.swift
//  ShoppingList
//
//  Created by Javid Museyibli on 14.09.21.
//

import SwiftUI

struct CreateView: View {
    @State private var name: String = ""
    @State private var date: Date = Date()
    @State private var remindMe = false
    @Environment(\.presentationMode) var presentationMode

    var viewModel: ShoppingListViewModel

    var body: some View {
        ZStack(alignment: .top) {
            Form {
                TextField("Name", text: $name)
                    .padding(.vertical)
                Toggle("Remind me", isOn: $remindMe)
                if remindMe {
                    DatePicker("Remind me", selection: $date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding(.vertical)
                }
                CenteredButton(title: "Create", action: {
                    viewModel.saveItem(with: name, and: remindMe ? date : nil)
                    viewModel.getList()
                    presentationMode.wrappedValue.dismiss()
                }, isDisabled: .constant(name.count == 0))
            }
            PresentedViewTopIndicator()
        }

    }
}

