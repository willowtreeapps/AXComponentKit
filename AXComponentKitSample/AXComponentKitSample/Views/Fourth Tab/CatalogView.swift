import AXComponentKit
import SwiftUI

struct CatalogView: View {
    @State private var path = NavigationPath()

    private let featuredItems = 1 ... 8

    var body: some View {
        NavigationStack(path: $path) {
            List {
                Section("Featured") {
                    ScrollView(.horizontal) {
                        HStack(spacing: 12) {
                            ForEach(featuredItems, id: \.self) { index in
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.blue.opacity(0.2))
                                    .frame(width: 120, height: 80)
                                    .overlay(Text("Item \(index)"))
                                    .automationComponent(\CatalogScreen.featuredItem, value: index)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .automationScrollView(\CatalogScreen.featuredCarousel)
                    .listRowInsets(EdgeInsets())
                }

                Section("Categories") {
                    ForEach(Category.allCases, id: \.self) { category in
                        Button(category.displayName) {
                            path.append(category)
                        }
                        .automationComponent(\CatalogScreen.categoryCard, value: category)
                    }
                }
            }
            .automationScrollView(\CatalogScreen.categoryList)
            .navigationTitle("Catalog")
            .navigationDestination(for: Category.self) { category in
                CategoryDetailView(category: category)
            }
        }
        .automationScreen(CatalogScreen.self)
    }
}
