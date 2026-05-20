import AXComponentKit
import Foundation
import XCTest

@MainActor
public extension AXScreen {
    /// Finds the element identified by the given key path, waits for it to
    /// exist, then taps it.
    static func tap(
        _ path: KeyPath<Self, AXComponent>,
        timeout: Measurement<UnitDuration> = .seconds(10),
        file: StaticString = #file,
        line: UInt = #line
    ) async throws {
        try await element(path, timeout: timeout, file: file, line: line).tap()
    }

    /// Finds the dynamic element, waits for it to exist, then taps it.
    static func tap<Value>(
        _ path: KeyPath<Self, AXDynamicComponent<Value>>,
        value: Value,
        timeout: Measurement<UnitDuration> = .seconds(10),
        file: StaticString = #file,
        line: UInt = #line
    ) async throws {
        try await element(path, value: value, timeout: timeout, file: file, line: line).tap()
    }
}
