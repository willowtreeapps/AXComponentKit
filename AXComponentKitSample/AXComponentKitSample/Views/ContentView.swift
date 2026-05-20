import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            FirstTabView()
                .tabItem {
                    Label("First", systemImage: "star")
                }
            SecondTabView()
                .tabItem {
                    Label("Second", systemImage: "circle")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
            CatalogView()
                .tabItem {
                    Label("Catalog", systemImage: "square.grid.2x2")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
