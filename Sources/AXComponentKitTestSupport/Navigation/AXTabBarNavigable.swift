import AXComponentKit
import Foundation

public protocol AXTabBarNavigable {}

public extension AXScreen where Self: AXTabBarNavigable {
    @discardableResult
    static func navigate<Destination>(
        toTab path: KeyPath<Self, AXTabComponent<Destination>>,
        timeout _: Measurement<UnitDuration> = .seconds(10),
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> AXScreenNavigator<Destination> where Destination: AXScreen {
        try await Navigator().navigate(toTab: path, file: file, line: line)
    }
}

public extension AXScreenNavigator where Source: AXTabBarNavigable {
    @discardableResult
    func navigate<Destination>(
        toTab path: KeyPath<Source, AXTabComponent<Destination>>,
        timeout _: Measurement<UnitDuration> = .seconds(10),
        file: StaticString = #file,
        line: UInt = #line
    ) async throws -> AXScreenNavigator<Destination> where Destination: AXScreen {
        try await performNavigation(to: Destination.self, file: file, line: line) { source in
            try await source.element(path, file: file, line: line).tap()
        }
    }
}
