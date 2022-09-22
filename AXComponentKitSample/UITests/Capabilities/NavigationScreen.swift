import XCTest

protocol NavigationScreen {}

extension NavigationScreen {
    static var backButton: XCUIElement {
        XCUIApplication().navigationBars.buttons.element(boundBy: 0)
    }

    static func titleLabel(matching title: String) -> XCUIElement {
        XCUIApplication().navigationBars[title].firstMatch
    }
}
