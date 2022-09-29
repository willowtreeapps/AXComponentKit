import XCTest

@MainActor
final class SecondTabScreenTests: XCTestCase {
    override func setUp(completion: @escaping (Error?) -> Void) {
        setUp(completion: completion) {
            XCUIApplication().launch()
            try await FirstTabScreen.navigate(toTab: \.second)
        }
    }

    func testCanTapSpecificRow() async throws {
        let row = try await SecondTabScreen.element(\.rowItem, value: 3)
        row.tap()
    }

    func testCanNavigateToDetailScreen() async throws {
        try await SecondTabScreen.navigate(toItem: 3)
    }

    func testCanScrollDownAndNavigate() async throws {
        try await SecondTabScreen.navigate(toItem: 80)
    }
}
