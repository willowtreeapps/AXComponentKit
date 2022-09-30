import Foundation

/// Defines a logical automation component that can exist within
/// an application's view hierarchy. This represents an element with
/// a partial identifier that gets supplemented at runtime with a generic
/// value.
///
/// `AXDynamicComponent`s resolve to an `AXComponent` when
/// given a `Value` and are useful in situations where dynamic identifiers
/// may not be knowable at compile-time. For example, list rows can have
/// fully unique identifiers for each row if the `Value` is something unique
/// such as a row index, or model object UUID.
public struct AXDynamicComponent<Value>: ExpressibleByStringLiteral {
    /// The static prefix for this component
    internal let prefix: String

    /// Creates a new `AXDynamicComponent` with the given prefix,
    /// which will be dynamically concatenated to a suffix at runtime.
    public init(stringLiteral value: StringLiteralType) {
        prefix = value
    }

    /// Resolves an `AXComponent` by combining the existing prefix
    /// with the provided suffix.
    ///
    /// - Parameter suffix:
    ///         The trailing end of the computed identifier
    /// - Returns:
    ///         A new, fully qualified `AXComponent`
    internal func resolve(with suffix: String) -> AXComponent {
        let components = [prefix, suffix].filter {
            !$0.isEmpty
        }
        let identifier = components.joined(separator: "_")
        return AXComponent(stringLiteral: identifier)
    }
}

public extension AXDynamicComponent where Value: AXDynamicValue {
    /// Resolves an `AXComponent` by combining the existing prefix
    /// with the provided suffix.
    ///
    /// - Parameter suffix:
    ///         The trailing end of the computed identifier
    /// - Returns:
    ///         A new, fully qualified `AXComponent`
    func resolve(_ suffix: Value) -> AXComponent {
        resolve(with: suffix.automationDynamicValue)
    }
}

public extension AXDynamicComponent where Value: StringProtocol {
    /// Resolves an `AXComponent` by combining the existing prefix
    /// with the provided suffix.
    ///
    /// - Parameter suffix:
    ///         The trailing end of the computed identifier
    /// - Returns:
    ///         A new, fully qualified `AXComponent`
    func resolve(_ suffix: Value) -> AXComponent {
        resolve(with: String(suffix))
    }
}

public extension AXDynamicComponent where Value: SignedInteger {
    /// Resolves an `AXComponent` by combining the existing prefix
    /// with the provided suffix.
    ///
    /// - Parameter suffix:
    ///         The trailing end of the computed identifier
    /// - Returns:
    ///         A new, fully qualified `AXComponent`
    func resolve(_ suffix: Value) -> AXComponent {
        resolve(with: String(suffix))
    }
}

public extension AXDynamicComponent where Value: UnsignedInteger {
    /// Resolves an `AXComponent` by combining the existing prefix
    /// with the provided suffix.
    ///
    /// - Parameter suffix:
    ///         The trailing end of the computed identifier
    /// - Returns:
    ///         A new, fully qualified `AXComponent`
    func resolve(_ suffix: Value) -> AXComponent {
        resolve(with: String(suffix))
    }
}
