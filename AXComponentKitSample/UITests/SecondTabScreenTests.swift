//
//  SecondTabScreenTests.swift
//  UITests
//
//  Created by Chris Stroud on 9/28/22.
//

import XCTest

@MainActor
final class SecondTabScreenTests: XCTestCase {

    override func setUp() {
        XCUIApplication().launch()
        Task {
            await FirstTabScreen.Navigator().navigateToTab(\.secondTab)
        }
    }

    func testCanTapSpecificRow() async {
        let row = await SecondTabScreen.element(\.rowItem, value: 3)
        row.tap()
    }

    func testCanNavigateToDetailScreen() async {
        let navigator = SecondTabScreen.Navigator()
        await navigator.navigateToItem(at: 3)
    }

    func testCanScrollDownAndNavigate() async {
        let navigator = SecondTabScreen.Navigator()
        await navigator.navigateToItem(at: 2)
    }
}
