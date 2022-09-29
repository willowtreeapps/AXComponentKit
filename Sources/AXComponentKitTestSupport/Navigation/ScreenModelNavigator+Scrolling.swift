import AXComponentKit
import Foundation
import XCTest

public extension ScreenModelNavigator {
    fileprivate struct ScrollTransaction {
        let source: CGVector
        let destination: CGVector

        init(from: (x: CGFloat, y: CGFloat), to: (x: CGFloat, y: CGFloat)) {
            source = .init(dx: from.x, dy: from.y)
            destination = .init(dx: to.x, dy: to.y)
        }
    }

    enum ScrollDirection {
        case up
        case down
        case left
        case right

        fileprivate var transaction: ScrollTransaction {
            switch self {
            case .up:
                return .init(
                    from: (x: 0.5, y: 0.25),
                    to: (x: 0.5, y: 1.0)
                )
            case .down:
                return .init(
                    from: (x: 0.5, y: 0.9),
                    to: (x: 0.5, y: 0.0)
                )
            case .left:
                return .init(
                    from: (x: 0.25, y: 0.5),
                    to: (x: 1.0, y: 0.5)
                )
            case .right:
                return .init(
                    from: (x: 0.75, y: 0.5),
                    to: (x: 0.0, y: 0.5)
                )
            }
        }
    }

    func scroll(
        _ direction: ScrollDirection,
        to element: XCUIElement,
        in path: KeyPath<Source, AXScrollView>,
        timeout: Measurement<UnitDuration> = .seconds(20),
        file: StaticString = #file,
        line: UInt = #line
    ) async {
        let start = Date()

        while true {
            if element.exists {
                return
            }
            if Date().timeIntervalSince(start) > timeout.timeInterval {
                XCTFail("Timed out", file: file, line: line)
                return
            }

            let scrollView = await Source.element(path, file: file, line: line)
            let transaction = direction.transaction
            let start = scrollView.coordinate(withNormalizedOffset: transaction.source)
            let end = scrollView.coordinate(withNormalizedOffset: transaction.destination)

            start.press(
                forDuration: 0.1,
                thenDragTo: end,
                withVelocity: .default,
                thenHoldForDuration: 0.1
            )
        }
    }
}
