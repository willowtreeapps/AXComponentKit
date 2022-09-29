import XCTest

@MainActor
final class SecondTabScreenTests: XCTestCase {
    override func setUp() {
        XCUIApplication().launch()
        Task {
            await FirstTabScreen.navigate(toTab: \.second)
        }
    }

    func testCanTapSpecificRow() async {
        let row = await SecondTabScreen.element(\.rowItem, value: 3)
        row.tap()
    }

    func testCanNavigateToDetailScreen() async {
        await SecondTabScreen.navigate(toItem: 3)
    }

    func testCanScrollDownAndNavigate() async {
        await SecondTabScreen.navigate(toItem: 200)
    }
}
