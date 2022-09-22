import Foundation

public struct AXComponent: ExpressibleByStringLiteral {
    public let id: String

    public init(stringLiteral value: StringLiteralType) {
        id = value
    }

    public init<Prefix, Value>(
        prefix: @autoclosure () -> Prefix,
        _ value: @autoclosure () -> Value
    ) where Prefix: StringProtocol, Value: StringProtocol {
        id = "\(prefix())-\(value())"
    }
}
