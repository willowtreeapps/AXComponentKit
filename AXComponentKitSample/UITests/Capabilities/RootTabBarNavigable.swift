import AXComponentKit
import AXComponentKitTestSupport
import XCTest

protocol RootTabBarNavigable: AXTabBarNavigable {}

extension RootTabBarNavigable {
    var firstTab: AXTabComponent<FirstTabScreen> {
        .init(index: 0, name: "First")
    }

    var secondTab: AXTabComponent<SecondTabScreen> {
        .init(index: 1, name: "Second")
    }

    var ghostTab: AXTabComponent<SecondTabScreen> {
        .init(index: 2, name: "No u")
    }
}

