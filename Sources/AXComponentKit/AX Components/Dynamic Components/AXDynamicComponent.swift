import Foundation

public struct AXDynamicComponent<Value>: ExpressibleByStringLiteral {
    internal let prefix: String

    public init(stringLiteral value: StringLiteralType) {
        prefix = value
    }

    internal func resolve(with suffix: String) -> AXComponent {
        let components = [prefix, suffix].filter {
            !$0.isEmpty
        }
        let identifier = components.joined(separator: "_")
        return AXComponent(stringLiteral: identifier)
    }
}

public extension AXDynamicComponent where Value: AXDynamicValue {
    func resolve(_ suffix: Value) -> AXComponent {
        resolve(with: suffix.automationDynamicValue)
    }
}

public extension AXDynamicComponent where Value: StringProtocol {
    func resolve(_ suffix: Value) -> AXComponent {
        resolve(with: String(suffix))
    }
}

public extension AXDynamicComponent where Value: SignedInteger {
    func resolve(_ suffix: Value) -> AXComponent {
        resolve(with: String(suffix))
    }
}

public extension AXDynamicComponent where Value: UnsignedInteger {
    func resolve(_ suffix: Value) -> AXComponent {
        resolve(with: String(suffix))
    }
}
