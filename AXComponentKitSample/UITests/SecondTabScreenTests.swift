import AXComponentKitTestSupport
import XCTest

@MainActor
final class SecondTabScreenTests: XCTestCase {
    override func setUp() async throws {
        XCUIApplication.automationLaunch()
        try await FirstTabScreen.navigator.navigate(toTab: \.second)
    }

    func testCanTapSpecificRow() async throws {
        let row = try await SecondTabScreen.element(\.rowItem, value: 3)
        row.tap()
    }

    func testCanNavigateToDetailScreen() async throws {
        try await SecondTabScreen.navigator.navigate(toItem: 3)
    }

    func testCanScrollDownAndNavigate() async throws {
        try await SecondTabScreen.navigator.navigate(toItem: 80)
    }
}
