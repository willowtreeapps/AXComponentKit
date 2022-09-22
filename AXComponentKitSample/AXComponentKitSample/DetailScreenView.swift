import AXComponentKit
import SwiftUI

struct DetailScreenView: View, Hashable {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .automationScreen(FirstTabDetailScreen.self)
    }
}

struct DetailScreenView_Previews: PreviewProvider {
    static var previews: some View {
        DetailScreenView()
    }
}
