import Foundation

/// Defines a logical screen that acts as a page model during testing
///
/// AXScreen provides a lightweight definition for what constitutes a "screen"
/// worth of content. Each screen has an identifier to help assist with navigation
/// while running tests.
public protocol AXScreen {
    /// Screen must be generically instantiable
    init()

    /// Unique identifier attached to the screen to ensure that it is visible while navigating.
    static var screenIdentifier: String { get }
}
