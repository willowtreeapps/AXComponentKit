import AXComponentKitTestSupport
import Foundation

extension ScreenModelNavigator where Source == FirstTabScreen {
    @discardableResult
    func navigateToDetailScreen(
        file _: StaticString = #file,
        line _: UInt = #line
    ) async -> ScreenModelNavigator<DetailScreen> {
        await performNavigation { screen in
            await screen.element(\.detailButton).tap()
        }
    }
}
