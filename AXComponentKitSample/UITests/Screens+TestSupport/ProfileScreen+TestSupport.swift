import AXComponentKit
import AXComponentKitTestSupport
import Foundation

extension ProfileScreen: DismissibleScreen {
    var dismissButton: AXComponent { closeButton }
}
