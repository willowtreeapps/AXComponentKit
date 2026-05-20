import AXComponentKit
import AXComponentKitTestSupport
import Foundation

extension AXScreenNavigator where Source == CategoryDetailScreen {
    @discardableResult
    func navigate(
        toItem index: Int,
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> AXScreenNavigator<ItemDetailScreen> {
        try await navigate(to: ItemDetailScreen.self, file: file, line: line) { screen in
            try await scroll(.down, to: \.item, value: index, in: \.itemList, file: file, line: line)
            let row = try await screen.element(\.item, value: index, file: file, line: line)
            row.tap()
        }
    }
}
