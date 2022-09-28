import AXComponentKitTestSupport
import Foundation

extension ScreenModelNavigator where Source == SecondTabScreen {
    @discardableResult
    func navigateToItem(
        at ordinal: Int,
        file _: StaticString = #file,
        line _: UInt = #line
    ) async -> ScreenModelNavigator<DetailScreen> {
        await performNavigation { screen in
            // TODO: may need to scroll
            await screen.element(\.rowItem, value: ordinal).tap()
        }
    }
}
