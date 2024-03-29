import AXComponentKit
import Foundation

struct SecondTabScreen: AXScreen {
    static let screenIdentifier = "second-tab-screen"

    let table: AXScrollView = "second-table-table-view"
    let rowItem: AXDynamicComponent<Int> = "second-tab-dynamic-row"
}
