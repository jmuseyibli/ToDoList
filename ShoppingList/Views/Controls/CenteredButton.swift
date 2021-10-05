//
//  CenteredButton.swift
//  ShoppingList
//
//  Created by Javid Museyibli on 12.09.21.
//

import SwiftUI

struct CenteredButton: View {
    let title: String
    let action: (() -> (Void))
    @Binding var isDisabled: Bool

    var body: some View {
        HStack {
            Spacer()
            Button(title, action: action)
            .padding(.all, 16)
            .disabled(isDisabled)
            Spacer()
        }
    }
}
