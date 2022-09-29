import AXComponentKit
import AXComponentKitTestSupport
import Foundation

extension FirstTabScreen {
    @discardableResult
    static func navigateToDetailScreen(
        file: StaticString = #file,
        line: UInt = #line
    ) async -> ScreenModelNavigator<DetailScreen> {
        await Navigator().navigateToDetailScreen(file: file, line: line)
    }
}

extension ScreenModelNavigator where Source == FirstTabScreen {
    @discardableResult
    func navigateToDetailScreen(
        file: StaticString = #file,
        line: UInt = #line
    ) async -> ScreenModelNavigator<DetailScreen> {
        await performNavigation(file: file, line: line) { screen in
            await screen.element(\.detailButton).tap()
        }
    }
}
