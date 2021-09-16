//
//  Checkbox.swift
//  ShoppingList
//
//  Created by Javid Museyibli on 12.09.21.
//

import SwiftUI

struct Checkbox: View {
    @Binding var isChecked: Bool
    @Binding var isCompact: Bool
    var body: some View {
        Image(systemName: isChecked ? "checkmark.circle.fill" : "circle")
            .renderingMode(.template)
            .resizable()
            .frame(width: isCompact ? 28 : 16, height: isCompact ? 28 : 16)
            .foregroundColor(isChecked ? .blue : .gray)
    }
}
