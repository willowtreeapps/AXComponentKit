import AXComponentKit
import SwiftUI

struct SecondTabView: View {
    private let items = 1 ... 1000

    var body: some View {
        NavigationStack {
            Form {
                ForEach(items, id: \.self) { item in
                    NavigationLink("Item \(item)", destination: DetailView(title: "Detail item \(item)"))
                        .automationComponent(\SecondTabScreen.rowItem, value: item)
                }
            }
            .automationScrollView(\SecondTabScreen.table)
            .navigationTitle("Second Tab")
        }
        .automationScreen(SecondTabScreen.self)
    }
}
