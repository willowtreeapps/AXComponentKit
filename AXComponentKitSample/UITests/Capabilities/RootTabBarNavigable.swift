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

// extension ScreenModelNavigator where Source: RootTabBarNavigable {
//    private func navigateToTab<Destination: AXScreenModel>(
//        _ path: KeyPath<RootTabBarNavigable, XCUIElement>,
//        named name: String,
//        destination: Destination.Type,
//        timeout: Measurement<UnitDuration>,
//        file: StaticString,
//        line: UInt
//    ) async -> ScreenModelNavigator<Destination> {
//        await performNavigation(to: destination) { source in
//            let tab = source.init()[keyPath: path]
//            let tabExists = tab.waitForExistence(timeout: timeout.timeInterval)
//            XCTAssertTrue(tabExists, "Expected tab \"\(name)\" not found", file: file, line: line)
//            tab.tap()
//        }
//    }
//
//    @discardableResult
//    func navigateToFirstTab(
//        timeout: Measurement<UnitDuration> = .seconds(10),
//        file: StaticString = #file,
//        line: UInt = #line
//    ) async -> ScreenModelNavigator<FirstTabScreen> {
//        await navigateToTab(\.firstTab,
//                             named: "Home",
//                             destination: FirstTabScreen.self,
//                             timeout: timeout,
//                             file: file,
//                             line: line)
//    }
//
//    @discardableResult
//    func navigateToSecondTab(
//        timeout: Measurement<UnitDuration> = .seconds(10),
//        file: StaticString = #file,
//        line: UInt = #line
//    ) async -> ScreenModelNavigator<SecondTabScreen> {
//        await navigateToTab(\.secondTab,
//                             named: "Plans",
//                             destination: SecondTabScreen.self,
//                             timeout: timeout,
//                             file: file,
//                             line: line)
//    }
// }
