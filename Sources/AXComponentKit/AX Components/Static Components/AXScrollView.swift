import Foundation

public struct AXScrollView: ExpressibleByStringLiteral {
    public let id: String

    public init(stringLiteral value: StringLiteralType) {
        id = value
    }
}
