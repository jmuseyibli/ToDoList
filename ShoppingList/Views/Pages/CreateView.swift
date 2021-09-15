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
    @State private var image = UIImage()
    @State private var isPresentingPhotoPicker = false
    @Environment(\.presentationMode) var presentationMode

    var viewModel: ShoppingListViewModel

    var body: some View {
        ZStack(alignment: .top) {
            Form {
                Section(header: Text("Image")) {
                    ImagePickerButton(isPresentingPhotoPicker: $isPresentingPhotoPicker, image: $image)
                }.padding(0)
                Section(header: Text("Details")) {
                    TextField("Name", text: $name)
                        .padding(.vertical)
                    Toggle("Remind me", isOn: $remindMe)
                        .padding(.vertical, 12)
                    if remindMe {
                        DatePicker("Remind me", selection: $date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .padding(.vertical)
                    }
                    CenteredButton(title: "Create", action: {
                        let identifier = UUID()
                        viewModel.saveItem(withIdentifier: identifier, named: name, remindedAt: remindMe ? date : nil)
                        saveImage(image, name: identifier.uuidString)
                        viewModel.getList()
                        presentationMode.wrappedValue.dismiss()
                    }, isDisabled: .constant(name.count == 0))
                }
            }
            PresentedViewTopIndicator()
        }
        .sheet(isPresented: $isPresentingPhotoPicker, content: {
            PhotoPickerView(image: $image)
        })

    }

    func saveImage(_ image: UIImage, name: String) {
        let filename = "\(name).jpg"
        if !image.isEmpty {
            let data = image.jpegData(compressionQuality: 0.5)
            do {
                if let url = ShoppingItem.photoURL(filename: filename) {
                    try data?.write(to: url, options: .atomic)
                }
            } catch {
                print(error)
            }
        }
    }

}

struct CreateView_Preview: PreviewProvider {
    static var previews: some View {
        CreateView(viewModel: ShoppingListViewModel())
    }
}
