import AXComponentKit
import XCTest

public extension AXScreenModel {
    typealias Navigator = ScreenModelNavigator<Self>
}

@MainActor
public struct ScreenModelNavigator<Source> where Source: AXScreenModel {
    let assertSourceExists: Bool
    init(assertSourceExists: Bool) {
        self.assertSourceExists = assertSourceExists
    }

    public init() {
        assertSourceExists = true
    }

    public func onlyNavigateIfNeeded() -> Self {
        Self(assertSourceExists: false)
    }

    private func waitForScreenToExist(
        timeout duration: Measurement<UnitDuration> = .seconds(10)
    ) async -> Bool {
        XCUIApplication()
            .descendants(matching: .any)
            .matching(identifier: Source.screenIdentifier)
            .firstMatch
            .waitForExistence(timeout: duration.timeInterval)
    }

    public func performNavigation<Destination>(
        to _: Destination.Type,
        timeout: Measurement<UnitDuration> = .seconds(10),
        file: StaticString = #file,
        line: UInt = #line,
        actions: (Source.Type) async -> Void
    ) async -> ScreenModelNavigator<Destination> where Destination: AXScreenModel {
        await performNavigation(timeout: timeout, file: file, line: line, actions: actions)
    }

    public func performNavigation<Destination>(
        timeout: Measurement<UnitDuration> = .seconds(10),
        file: StaticString = #file,
        line: UInt = #line,
        actions: (Source.Type) async -> Void
    ) async -> ScreenModelNavigator<Destination> where Destination: AXScreenModel {
        let sourceExists = await waitForScreenToExist(timeout: timeout)

        if assertSourceExists, !sourceExists {
            let message = "Source screen not found: \(type(of: Source.self))"
            XCTFail(message, file: file, line: line)
        }

        if sourceExists {
            await actions(Source.self) // Caller navigates to destination
        }

        let navigator = ScreenModelNavigator<Destination>(assertSourceExists: assertSourceExists)
        let destinationExists = await navigator.waitForScreenToExist(timeout: timeout)
        if !destinationExists {
            let message = "Destination screen not found: \(type(of: Destination.self))"
            XCTFail(message, file: file, line: line)
        }
        return navigator
    }
}
