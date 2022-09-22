import Foundation
import XCTest

final class AXFailure: NSError {
    init(_ message: String, file: StaticString, line: UInt) {
        XCTFail(message, file: file, line: line)
        super.init(
            domain: "com.axcomponentkit.testsupport",
            code: 1,
            userInfo: [
                NSLocalizedDescriptionKey: message,
            ]
        )
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError()
    }
}
