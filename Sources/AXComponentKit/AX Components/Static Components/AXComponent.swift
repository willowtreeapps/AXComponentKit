import Foundation

/// Defines a logical automation component that can exist within
/// an application's view hierarchy. This represents an element with
/// a fully qualified identifier, be it a static element that is predefined,
/// or the result of resolving an `AXDynamicComponent` with some value.
public struct AXComponent: ExpressibleByStringLiteral {
    /// The identifier for the component
    public let id: String

    /// Creates a new `AXComponent` with a static identifier
    public init(stringLiteral value: StringLiteralType) {
        id = value
    }

    /// Creates a new `AXComponent` from a prefix and value
    ///
    /// This helps facilitate nested components with more complex hierarchies
    ///
    /// - Parameters:
    ///   - prefix:
    ///        Prefix of the computed identifier
    ///   - value:
    ///        The value (suffix) of the computed identifier
    public init<Prefix, Value>(
        prefix: @autoclosure () -> Prefix,
        _ value: @autoclosure () -> Value
    ) where Prefix: StringProtocol, Value: StringProtocol {
        id = "\(prefix())-\(value())"
    }
}
