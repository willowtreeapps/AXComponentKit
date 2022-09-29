import AXComponentKitTestSupport
import XCTest

@MainActor
final class UITests: XCTestCase {
    override func setUp(completion: @escaping (Error?) -> Void) {
        setUp(completion: completion) {
            XCUIApplication().launch()
        }
    }

    func testFirstPageElementsExist() async throws {
        try await FirstTabScreen.exists()

        try await FirstTabScreen.element(\.detailButton)

        let button = FirstTabScreen.assumedElement(\.detailButton)

        while !button.exists {
            XCUIApplication().scroll(byDeltaX: 0, deltaY: 10)
        }
    }

    func testCanNavigateToDetailScreen() async throws {
        try await FirstTabScreen.navigateToDetailScreen()
    }
}
