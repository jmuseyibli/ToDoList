//
//  PhotoPickerView.swift
//  ShoppingList
//
//  Created by Javid Museyibli on 15.09.21.
//

import SwiftUI

struct PhotoPickerView: UIViewControllerRepresentable {
    @Binding var image: UIImage

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let pickerController = UIImagePickerController()
        pickerController.allowsEditing = true
        pickerController.delegate = context.coordinator
        return pickerController
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(photoPicker: self)
    }
    
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let photoPicker: PhotoPickerView

        init(photoPicker: PhotoPickerView) {
            self.photoPicker = photoPicker
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage {
                photoPicker.image = image
            }
            picker.dismiss(animated: true)
        }
    }
}
