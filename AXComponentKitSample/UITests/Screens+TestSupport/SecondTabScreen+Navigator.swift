import AXComponentKitTestSupport
import Foundation

extension AXScreenNavigator where Source == SecondTabScreen {
    @discardableResult
    func navigate(
        toItem ordinal: Int,
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> AXScreenNavigator<DetailScreen> {
        try await navigate(file: file, line: line) { screen in
            try await scroll(to: \.rowItem, value: ordinal, in: \.table, file: file, line: line)
            let rowItem = try await screen.element(\.rowItem, value: ordinal, file: file, line: line)
            rowItem.tap()
        }
    }
}
