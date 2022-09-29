import AXComponentKitTestSupport
import XCTest

@MainActor
final class UITests: XCTestCase {
    override func setUp() {
        XCUIApplication().launch()
    }

    func testFirstPageElementsExist() async {
        await FirstTabScreen.exists()

        await FirstTabScreen.element(\.detailButton)

        let button = FirstTabScreen.assumedElement(\.detailButton)

        while !button.exists {
            XCUIApplication().scroll(byDeltaX: 0, deltaY: 10)
        }
    }

    func testCanNavigateToDetailScreen() async {
        await FirstTabScreen.navigateToDetailScreen()
    }
}
