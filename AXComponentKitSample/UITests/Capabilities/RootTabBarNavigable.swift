import AXComponentKit
import AXComponentKitTestSupport
import XCTest

protocol RootTabBarNavigable: AXTabBarNavigable {}

extension RootTabBarNavigable {
    var first: AXTabComponent<FirstTabScreen> {
        .init(name: "First")
    }

    var second: AXTabComponent<SecondTabScreen> {
        .init(name: "Second")
    }

    var ghost: AXTabComponent<SecondTabScreen> {
        .init(name: "No u")
    }
}
