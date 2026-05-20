import AXComponentKit
import AXComponentKitTestSupport
import Foundation

extension AXScreenNavigator where Source == CatalogScreen {
    @discardableResult
    func navigate(
        toCategory category: Category,
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> AXScreenNavigator<CategoryDetailScreen> {
        try await navigate(to: CategoryDetailScreen.self, file: file, line: line) { screen in
            try await scroll(.down, to: \.categoryCard, value: category, in: \.categoryList, file: file, line: line)
            let card = try await screen.element(\.categoryCard, value: category, file: file, line: line)
            card.tap()
        }
    }
}
