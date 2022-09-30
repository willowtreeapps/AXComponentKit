import Foundation

/// Defines a logical view that encompasses scrolling behavior in a generic
/// sense. This tells `AXComponentKit` that the element in question is
/// scrollable without forcing any heuristic to try and detect the most relevant
/// scroll view.
public struct AXScrollView: ExpressibleByStringLiteral {
    public let id: String

    public init(stringLiteral value: StringLiteralType) {
        id = value
    }
}
