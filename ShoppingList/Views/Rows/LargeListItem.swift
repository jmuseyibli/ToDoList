//
//  LargeListItem.swift
//  ShoppingList
//
//  Created by Javid Museyibli on 16.09.21.
//

import SwiftUI
import SafariServices

struct LargeListItem: View {
    @Binding var shoppingItem: ShoppingItem
    @Binding var isCompact: Bool
    @State var isLinkPresented: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 4) {
                Spacer()
                Text(shoppingItem.isCompleted ? "Completed" : "Incomplete")
                    .font(.system(size: 14))
                    .foregroundColor(shoppingItem.isCompleted ? .blue : .secondary)
                Checkbox(isChecked: $shoppingItem.isCompleted, isCompact: $isCompact)
            }
            if let image = shoppingItem.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .cornerRadius(8)
            }
            Text(shoppingItem.name)
                .foregroundColor(shoppingItem.isCompleted ? .blue : .black)
            HStack(spacing: 4) {
                if shoppingItem.hasLink {
                    ItemLink(link: shoppingItem.link!).onTapGesture {
                        isLinkPresented = true
                    }
                }
                Spacer()
                Image(systemName: "arrow.down.right.and.arrow.up.left")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        isCompact = true
                    }
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 24)
        .onTapGesture {
            shoppingItem.isCompleted.toggle()
            CoreDataManager.shared.saveContext()
        }
        .sheet(isPresented: $isLinkPresented, content: { () -> SafariView in
            let link = URL(string: shoppingItem.link!)
            return SafariView(url: link!)
        })
    }
}

struct LargeListItem_Previews: PreviewProvider {
    static let cdItem: CDShoppingItem = {
        let cdItem = CDShoppingItem(context: CoreDataManager.shared.viewContext)
        cdItem.id = UUID()
        cdItem.name = "Sample row might be long"
        cdItem.filename = "name.jpg"
        cdItem.dueDate = Date()
        cdItem.link = "Salam"
        return cdItem
    }()

    static var previews: some View {
        LargeListItem(shoppingItem: .constant(ShoppingItem(item: cdItem)), isCompact: .constant(false)).previewLayout(.sizeThatFits)
    }
}


struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {}
}

struct ItemLink: View {
    let link: String
    var body: some View {
        HStack {
            Image(systemName: "link")
                .resizable()
                .frame(width: 16, height: 16)
                .foregroundColor(.blue)
            Text(link)
                .foregroundColor(.blue)
                .fontWeight(.medium)
        }
    }
}
