//
//  UIImage+Extensions.swift
//  ShoppingList
//
//  Created by Javid Museyibli on 15.09.21.
//

import UIKit

extension UIImage {
    var isEmpty: Bool {
        self.pngData()?.isEmpty ?? true
    }
}
