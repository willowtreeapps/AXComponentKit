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

    var settings: AXTabComponent<SettingsScreen> {
        .init(name: "Settings")
    }

    var catalog: AXTabComponent<CatalogScreen> {
        .init(name: "Catalog")
    }

}
