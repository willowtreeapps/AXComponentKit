import AXComponentKit
import XCTest

public extension AXScreen {
    typealias Navigator = AXScreenNavigator<Self>
}

@MainActor
public struct AXScreenNavigator<Source> where Source: AXScreen {
    public init() {}

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
        actions: (Source.Type) async throws -> Void
    ) async throws -> AXScreenNavigator<Destination> where Destination: AXScreen {
        try await performNavigation(timeout: timeout, file: file, line: line, actions: actions)
    }

    public func performNavigation<Destination>(
        timeout: Measurement<UnitDuration> = .seconds(10),
        file: StaticString = #file,
        line: UInt = #line,
        actions: (Source.Type) async throws -> Void
    ) async throws -> AXScreenNavigator<Destination> where Destination: AXScreen {
        let sourceExists = await waitForScreenToExist(timeout: timeout)

        if !sourceExists {
            let message = "Source screen not found: \(type(of: Source.self))"
            throw AXFailure(message, file: file, line: line)
        }

        if sourceExists {
            try await actions(Source.self) // Caller navigates to destination
        }

        let navigator = AXScreenNavigator<Destination>()
        let destinationExists = await navigator.waitForScreenToExist(timeout: timeout)
        if !destinationExists {
            let message = "Destination screen not found: \(type(of: Destination.self))"
            throw AXFailure(message, file: file, line: line)
        }
        return navigator
    }
}
