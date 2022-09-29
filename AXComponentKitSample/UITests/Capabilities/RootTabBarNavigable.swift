import AXComponentKit
import AXComponentKitTestSupport
import XCTest

protocol RootTabBarNavigable: AXTabBarNavigable {}

extension RootTabBarNavigable {
    var first: AXTabComponent<FirstTabScreen> {
        .init(index: 0, name: "First")
    }

    var second: AXTabComponent<SecondTabScreen> {
        .init(index: 1, name: "Second")
    }

    var ghost: AXTabComponent<SecondTabScreen> {
        .init(index: 2, name: "No u")
    }
}
