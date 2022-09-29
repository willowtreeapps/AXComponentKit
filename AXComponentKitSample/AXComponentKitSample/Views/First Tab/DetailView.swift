import AXComponentKit
import SwiftUI

struct DetailView: View {
    private(set) var title = "Hello, World!"

    var body: some View {
        Group {
            Text(title)
                .automationComponent(\DetailScreen.contentLabel)
        }
        .automationScreen(DetailScreen.self)
    }
}

struct DetailScreenView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
