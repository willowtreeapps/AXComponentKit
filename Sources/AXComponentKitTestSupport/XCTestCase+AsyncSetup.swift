import Foundation
import XCTest

public extension XCTestCase {
    /// Allows the setup of an `XCTestCase` to be performed as an
    /// async operation. Handles the `completion()` automatically
    /// by catching any errors thrown and passing them in, or
    /// by passing `nil` otherwise.
    ///
    /// ```
    /// @MainActor
    /// final class ExampleScreenTests: XCTestCase {
    ///     override func setUp(completion: @escaping (Error?) -> Void) {
    ///         setUp(completion: completion) {
    ///             XCUIApplication().launch()
    ///             try await ExampleScreen.navigate(toTab: \.someTab)
    ///         }
    ///     }
    /// }
    /// ```
    /// - Parameters:
    ///   - completion:
    ///       The `XCTestCase` setup completion handler
    ///   - actions:
    ///       The actions to perform during setup
    func setUp(
        completion: @escaping (Error?) -> Void,
        _ actions: @escaping () async throws -> Void
    ) {
        Task {
            do {
                try await actions()
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }
}
