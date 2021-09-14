//
//  Checkbox.swift
//  ShoppingList
//
//  Created by Javid Museyibli on 12.09.21.
//

import SwiftUI

struct Checkbox: View {
    @Binding var isChecked: Bool
    var body: some View {
        Image(systemName: isChecked ? "checkmark.circle.fill" : "circle")
            .renderingMode(.template)
            .resizable()
            .frame(width: 28, height: 28)
            .foregroundColor(isChecked ? .blue : .gray)
            .padding(.trailing, 8)
    }
}
