import AXComponentKitTestSupport
import XCTest

@MainActor
final class FirstTabScreenTests: XCTestCase {
    override func setUp() async throws {
        XCUIApplication.automationLaunch()
    }

    func testFirstPageElementsExist() async throws {
        try await FirstTabScreen.exists()
        try await FirstTabScreen.element(\.detailButton)
    }

    func testCanNavigateToDetailScreen() async throws {
        try await FirstTabScreen.navigator.navigateToDetailScreen()
    }
}
