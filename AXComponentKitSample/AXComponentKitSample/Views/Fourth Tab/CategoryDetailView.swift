import AXComponentKit
import SwiftUI

struct CategoryDetailView: View {
    let category: Category
    private let items = 1 ... 50

    var body: some View {
        Form {
            ForEach(items, id: \.self) { index in
                NavigationLink("Item \(index)") {
                    ItemDetailView(itemIndex: index, category: category)
                }
                .automationComponent(\CategoryDetailScreen.item, value: index)
            }
        }
        .automationScrollView(\CategoryDetailScreen.itemList)
        .navigationTitle(category.displayName)
        .automationScreen(CategoryDetailScreen.self)
    }
}
