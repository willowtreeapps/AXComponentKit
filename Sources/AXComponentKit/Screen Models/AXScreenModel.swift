import Foundation

// Defines a page model for a particular screen
public protocol AXScreenModel {
    init()
    static var screenIdentifier: String { get }
}
