import AXComponentKit
import Foundation
import XCTest

public enum ScrollDirection {
    case up
    case down
    case left
    case right
}

public extension AXScreenNavigator {
    func scroll(
        _ direction: ScrollDirection = .down,
        to elementPath: KeyPath<Source, AXComponent>,
        in path: KeyPath<Source, AXScrollView>,
        timeout: Measurement<UnitDuration> = .seconds(30),
        file: StaticString = #file,
        line: UInt = #line
    ) async throws {
        let target = Source.assumedElement(elementPath, file: file, line: line)
        try await scroll(direction, to: target, in: path, timeout: timeout, file: file, line: line)
    }

    func scroll<Value>(
        _ direction: ScrollDirection = .down,
        to elementPath: KeyPath<Source, AXDynamicComponent<Value>>,
        value: Value,
        in path: KeyPath<Source, AXScrollView>,
        timeout: Measurement<UnitDuration> = .seconds(30),
        file: StaticString = #file,
        line: UInt = #line
    ) async throws where Value: AXDynamicValue {
        let target = Source.assumedElement(elementPath, value: value, file: file, line: line)
        try await scroll(direction, to: target, in: path, timeout: timeout, file: file, line: line)
    }

    func scroll<Value>(
        _ direction: ScrollDirection = .down,
        to elementPath: KeyPath<Source, AXDynamicComponent<Value>>,
        value: Value,
        in path: KeyPath<Source, AXScrollView>,
        timeout: Measurement<UnitDuration> = .seconds(30),
        file: StaticString = #file,
        line: UInt = #line
    ) async throws where Value: SignedInteger {
        let target = Source.assumedElement(elementPath, value: value, file: file, line: line)
        try await scroll(direction, to: target, in: path, timeout: timeout, file: file, line: line)
    }

    func scroll<Value>(
        _ direction: ScrollDirection = .down,
        to elementPath: KeyPath<Source, AXDynamicComponent<Value>>,
        value: Value,
        in path: KeyPath<Source, AXScrollView>,
        timeout: Measurement<UnitDuration> = .seconds(30),
        file: StaticString = #file,
        line: UInt = #line
    ) async throws where Value: UnsignedInteger {
        let target = Source.assumedElement(elementPath, value: value, file: file, line: line)
        try await scroll(direction, to: target, in: path, timeout: timeout, file: file, line: line)
    }

    func scroll<Value>(
        _ direction: ScrollDirection = .down,
        to elementPath: KeyPath<Source, AXDynamicComponent<Value>>,
        value: Value,
        in path: KeyPath<Source, AXScrollView>,
        timeout: Measurement<UnitDuration> = .seconds(30),
        file: StaticString = #file,
        line: UInt = #line
    ) async throws where Value: StringProtocol {
        let target = Source.assumedElement(elementPath, value: value, file: file, line: line)
        try await scroll(direction, to: target, in: path, timeout: timeout, file: file, line: line)
    }

    func scroll(
        _ direction: ScrollDirection = .down,
        to element: XCUIElement,
        in path: KeyPath<Source, AXScrollView>,
        timeout: Measurement<UnitDuration> = .seconds(30),
        file: StaticString = #file,
        line: UInt = #line
    ) async throws {
        let start = Date()

        while Date().timeIntervalSince(start) < timeout.timeInterval {
            if element.exists {
                return
            }

            let scrollView = try await Source.element(path, file: file, line: line)
            let transaction = ScrollTransaction(direction: direction)
            let start = scrollView.coordinate(withNormalizedOffset: transaction.source)
            let end = scrollView.coordinate(withNormalizedOffset: transaction.destination)

            start.press(
                forDuration: 0.1,
                thenDragTo: end,
                withVelocity: .default,
                thenHoldForDuration: 0.1
            )
        }

        throw AXFailure("Scrolling timed out. Element not found.", file: file, line: line)
    }
}
