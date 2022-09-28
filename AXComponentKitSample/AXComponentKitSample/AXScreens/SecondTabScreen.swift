import AXComponentKit
import Foundation

struct SecondTabScreen: AXScreenModel {
    static let screenIdentifier = "second-tab-screen"

    let rowItem: AXDynamicComponent<Int> = "second-tab-dynamic-row"
}
