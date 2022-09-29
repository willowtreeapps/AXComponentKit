import Foundation
import XCTest

public extension XCTestCase {
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
