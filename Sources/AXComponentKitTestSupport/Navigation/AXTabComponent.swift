import AXComponentKit
import Foundation

/// Identifies a `TabItem` by its name, since iOS doesn't allow developers to
/// specify accessibility identifiers for those elements.
public struct AXTabComponent<Content> where Content: AXScreen {
    /// The name of the represented tab. Must match the label of the tab at runtime.
    let name: String

    /// Creates a new `AXTabComponent` with the given name
    ///
    /// - Parameter name:
    ///        The name of the represented tab. Must match the label of the tab at runtime.
    public init(name: String) {
        self.name = name
    }
}
