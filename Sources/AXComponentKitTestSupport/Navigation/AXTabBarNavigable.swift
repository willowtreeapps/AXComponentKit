import AXComponentKit
import Foundation

public protocol AXTabBarNavigable {}

public extension AXScreenModel where Self: AXTabBarNavigable {
    @discardableResult
    static func navigate<Destination>(
        toTab path: KeyPath<Self, AXTabComponent<Destination>>,
        timeout _: Measurement<UnitDuration> = .seconds(10),
        file: StaticString = #file,
        line: UInt = #line
    ) async -> ScreenModelNavigator<Destination> where Destination: AXScreenModel {
        await Navigator().navigate(toTab: path, file: file, line: line)
    }
}

public extension ScreenModelNavigator where Source: AXTabBarNavigable {
    @discardableResult
    func navigate<Destination>(
        toTab path: KeyPath<Source, AXTabComponent<Destination>>,
        timeout _: Measurement<UnitDuration> = .seconds(10),
        file: StaticString = #file,
        line: UInt = #line
    ) async -> ScreenModelNavigator<Destination> where Destination: AXScreenModel {
        await performNavigation(to: Destination.self, file: file, line: line) { source in
            await source.element(path, file: file, line: line).tap()
        }
    }
}
