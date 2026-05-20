import AXComponentKit
import Foundation

public protocol AXTabBarNavigable {}

public extension AXScreenNavigator where Source: AXTabBarNavigable {
    /// Asynchronously navigates the test runner to the specified `AXTabComponent`
    /// once it comes into existence. Otherwise an error is thrown.
    ///
    /// - Parameters:
    ///   - path:
    ///         `KeyPath` relative to `Self` that identifies an `AXTabComponent`
    ///   - timeout:
    ///         Duration of time that this call should wait for the element to come into existence.
    ///         The default is 10 seconds.
    ///   - file:
    ///         The file to present an error in if a failure occurs.
    ///         The default is the filename of the test case where you call this function.
    ///   - line:
    ///         The line number to present an error on if a failure occurs.
    ///         The default is the line number of the test case where you call this function.
    /// - Returns:
    ///         An `AXScreenNavigator` that corresponds to the `Destination` screen.
    @discardableResult
    func navigate<Destination>(
        toTab path: KeyPath<Source, AXTabComponent<Destination>>,
        timeout: Measurement<UnitDuration> = .seconds(10),
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> AXScreenNavigator<Destination> where Destination: AXScreen {
        try await navigate(to: Destination.self, timeout: timeout, file: file, line: line) { source in
            try await source.element(path, timeout: timeout, file: file, line: line).tap()
        }
    }
}
