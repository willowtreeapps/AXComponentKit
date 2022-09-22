import UIKit

public extension UIAccessibilityIdentification {
    var automationComponent: AXComponent {
        get {
            AXComponent(stringLiteral: accessibilityIdentifier ?? "")
        }
        set {
            accessibilityIdentifier = newValue.id
        }
    }
}
