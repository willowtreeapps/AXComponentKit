import AXComponentKit
import Foundation
import XCTest

@MainActor
public extension AXScreen {
    // TODO: Make another pass with fresh eyes to make doubly sure
    // this tab query can't wait for existence

    @discardableResult
    static func element<Screen>(
        _ path: KeyPath<Self, AXTabComponent<Screen>>,
        timeout _: Measurement<UnitDuration> = .seconds(10),
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> XCUIElement where Screen: AXScreen {
        let element = try assumedElement(path, file: file, line: line)
        return element
    }

    static func assumedElement<Screen>(
        _ path: KeyPath<Self, AXTabComponent<Screen>>,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> XCUIElement where Screen: AXScreen {
        let component = Self()[keyPath: path]
        let index = Int(component.index)

        let tabItems = XCUIApplication().tabBars.buttons
        if !(0 ..< tabItems.count).contains(index) {
            throw AXFailure("\"\(component.name)\" tab not found", file: file, line: line)
        }
        let element = tabItems.element(boundBy: index)
        return element
    }
}
