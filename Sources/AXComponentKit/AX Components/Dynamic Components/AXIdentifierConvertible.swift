import Foundation

/// A type whose values can be converted to a string suitable for use
/// as part of an automation identifier.
///
/// Conform custom types to this protocol to use them as the `Value`
/// parameter of `AXDynamicComponent`. Standard library types like
/// `String`, `Int`, and `UInt` already conform.
public protocol AXIdentifierConvertible: Sendable {
    var automationIdentifier: String { get }
}

extension String: AXIdentifierConvertible {
    public var automationIdentifier: String { self }
}

extension Substring: AXIdentifierConvertible {
    public var automationIdentifier: String { String(self) }
}

extension Int: AXIdentifierConvertible {
    public var automationIdentifier: String { String(self) }
}

extension UInt: AXIdentifierConvertible {
    public var automationIdentifier: String { String(self) }
}

extension Int8: AXIdentifierConvertible {
    public var automationIdentifier: String { String(self) }
}

extension UInt8: AXIdentifierConvertible {
    public var automationIdentifier: String { String(self) }
}

extension Int16: AXIdentifierConvertible {
    public var automationIdentifier: String { String(self) }
}

extension UInt16: AXIdentifierConvertible {
    public var automationIdentifier: String { String(self) }
}

extension Int32: AXIdentifierConvertible {
    public var automationIdentifier: String { String(self) }
}

extension UInt32: AXIdentifierConvertible {
    public var automationIdentifier: String { String(self) }
}

extension Int64: AXIdentifierConvertible {
    public var automationIdentifier: String { String(self) }
}

extension UInt64: AXIdentifierConvertible {
    public var automationIdentifier: String { String(self) }
}
