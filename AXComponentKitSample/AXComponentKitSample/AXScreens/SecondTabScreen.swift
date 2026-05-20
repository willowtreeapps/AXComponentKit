import AXComponentKit
import AXComponentKitMacroSupport

@AXScreen
struct SecondTabScreen {
    let table: AXScrollView = "second-table-table-view"
    let rowItem: AXDynamicComponent<Int> = "second-tab-dynamic-row"
}
