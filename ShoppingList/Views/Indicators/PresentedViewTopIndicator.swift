//
//  PresentedViewTopIndicator.swift
//  ShoppingList
//
//  Created by Javid Museyibli on 14.09.21.
//

import SwiftUI

struct PresentedViewTopIndicator: View {
    var body: some View {
        HStack {
            Spacer()
            Rectangle()
                .frame(width: 64, height: 6)
                .foregroundColor(Color(white: 0.9))
                .cornerRadius(8)
            Spacer()
        }.padding(.top, 12)
    }
}

