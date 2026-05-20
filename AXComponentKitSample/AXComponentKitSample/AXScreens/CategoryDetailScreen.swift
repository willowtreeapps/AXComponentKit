import AXComponentKit
import AXComponentKitMacroSupport

@AXScreen
struct CategoryDetailScreen {
    let itemList: AXScrollView = "category-detail-item-list"
    let item: AXDynamicComponent<Int> = "category-detail-item"
}
