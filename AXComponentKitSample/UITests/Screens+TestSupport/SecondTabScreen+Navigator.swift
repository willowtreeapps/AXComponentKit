import AXComponentKitTestSupport
import Foundation

extension SecondTabScreen {
    @discardableResult
    static func navigate(
        toItem ordinal: Int,
        file: StaticString = #file,
        line: UInt = #line
    ) async -> ScreenModelNavigator<DetailScreen> {
        await Navigator().navigate(toItem: ordinal, file: file, line: line)
    }
}

extension ScreenModelNavigator where Source == SecondTabScreen {
    @discardableResult
    func navigate(
        toItem ordinal: Int,
        file: StaticString = #file,
        line: UInt = #line
    ) async -> ScreenModelNavigator<DetailScreen> {
        await performNavigation(file: file, line: line) { screen in

            let target = screen.assumedElement(\.rowItem, value: ordinal, file: file, line: line)
            await scroll(.down, to: target, in: \.table, timeout: .minutes(1), file: file, line: line)
            await screen.element(\.rowItem, value: ordinal, file: file, line: line).tap()
        }
    }
}
