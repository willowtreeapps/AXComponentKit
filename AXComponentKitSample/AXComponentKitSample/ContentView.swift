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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
