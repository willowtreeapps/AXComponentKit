import AXComponentKit
import Foundation

enum Category: String, CaseIterable, AXDynamicValue {
    case electronics
    case books
    case clothing

    var automationDynamicValue: String { rawValue }

    var displayName: String {
        switch self {
        case .electronics: "Electronics"
        case .books: "Books"
        case .clothing: "Clothing"
        }
    }
}
