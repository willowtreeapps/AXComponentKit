import UIKit

public extension UIAccessibilityIdentification {
    /// Allows a UIView to be assigned an automation component
    var automationComponent: AXComponent {
        get {
            AXComponent(stringLiteral: accessibilityIdentifier ?? "")
        }
        set {
            accessibilityIdentifier = newValue.id
        }
    }
}
