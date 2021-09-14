//
//  ImagePickerButton.swift
//  ShoppingList
//
//  Created by Javid Museyibli on 15.09.21.
//

import SwiftUI

struct ImagePickerButton: View {
    @Binding var isPresentingPhotoPicker: Bool
    @Binding var image: UIImage

    var body: some View {
        Button(action: { isPresentingPhotoPicker = true }, label: {
            HStack {
                Spacer()
                if !(image.isEmpty) {
                    VStack {
                        ZStack(alignment: .topTrailing) {
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 128, height: 128)
                                .cornerRadius(8)
                                .padding(10)
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .foregroundColor(Color(.lightGray))
                                .frame(width: 24, height: 24)
                                .background(Color(.black))
                                .cornerRadius(12)
                                .onTapGesture {
                                    image = UIImage()
                                }
                        }
                        Text("Choose another photo")
                    }
                } else {
                    HStack {
                        Image(systemName: "photo.on.rectangle")
                        Text("Select a photo")
                    }
                }
                Spacer()
            }.padding(.vertical, 16)
        })
    }
}
