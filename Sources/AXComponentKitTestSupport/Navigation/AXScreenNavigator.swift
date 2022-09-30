import AXComponentKit
import XCTest

public extension AXScreen {
    /// Convenience alias to easily obtain the `AXScreenNavigator` for a given `AXScreen`
    typealias Navigator = AXScreenNavigator<Self>
}

/// Provides a composable interface for navigating between screens of content
///
/// TODO: Make better
///
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

    /// Navigate the test runner from the `Source` screen to some `Destination` screen
    /// by providing actions to facilitate the navigation.
    ///
    /// This function ensures that the source screen exists before executing the provided actions
    /// and then ensures that the destination screen exists before returning. This is key to the
    /// composable nature of `AXScreenNavigator` and allows more specific, actionable
    /// errors to be surfaced.
    ///
    /// - Parameters:
    ///   - to:
    ///         The type of the `AXScreen` being navigated to
    ///   - timeout:
    ///         Duration of time that this call should wait for the element to come into existence.
    ///         The default is 10 seconds.
    ///   - file:
    ///         The file to present an error in if a failure occurs.
    ///         The default is the filename of the test case where you call this function.
    ///   - line:
    ///         The line number to present an error on if a failure occurs.
    ///         The default is the line number of the test case where you call this function.
    ///   - actions:
    ///         The actions to perform on the source screen that will transition to
    ///         the destination screen.
    ///         For example, in order to transition to a detail screen, one might first need
    ///         to tap on a collection view cell in order to facilitate that transition.
    /// - Returns:
    ///         An `AXScreenNavigator` that corresponds to the `Destination` screen.
    public func performNavigation<Destination>(
        to _: Destination.Type,
        timeout: Measurement<UnitDuration> = .seconds(10),
        file: StaticString = #file,
        line: UInt = #line,
        actions: (Source.Type) async throws -> Void
    ) async throws -> AXScreenNavigator<Destination> where Destination: AXScreen {
        try await performNavigation(timeout: timeout, file: file, line: line, actions: actions)
    }

    /// Navigate the test runner from the `Source` screen to some `Destination` screen
    /// by providing actions to facilitate the navigation.
    ///
    /// This function ensures that the source screen exists before executing the provided actions
    /// and then ensures that the destination screen exists before returning. This is key to the
    /// composable nature of `AXScreenNavigator` and allows more specific, actionable
    /// errors to be surfaced.
    ///
    /// - Parameters:
    ///   - timeout:
    ///         Duration of time that this call should wait for the element to come into existence.
    ///         The default is 10 seconds.
    ///   - file:
    ///         The file to present an error in if a failure occurs.
    ///         The default is the filename of the test case where you call this function.
    ///   - line:
    ///         The line number to present an error on if a failure occurs.
    ///         The default is the line number of the test case where you call this function.
    ///   - actions:
    ///         The actions to perform on the source screen that will transition to
    ///         the destination screen.
    ///         For example, in order to transition to a detail screen, one might first need
    ///         to tap on a collection view cell in order to facilitate that transition.
    /// - Returns:
    ///         An `AXScreenNavigator` that corresponds to the `Destination` screen.
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
