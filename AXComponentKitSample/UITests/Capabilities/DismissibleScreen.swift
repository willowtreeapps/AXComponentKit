import AXComponentKit
import AXComponentKitTestSupport
import XCTest

protocol DismissibleScreen: AXScreen {
    var dismissButton: AXComponent { get }
}

extension AXScreenNavigator where Source: DismissibleScreen {
    /// Taps the dismiss button on the current screen. Does not assert
    /// a destination screen — the caller should verify where they land
    /// after dismissal via `SomeScreen.exists()`.
    func dismiss(
        file: StaticString = #file,
        line: UInt = #line
    ) async throws {
        try await Source.element(\.dismissButton, file: file, line: line).tap()
    }
}
