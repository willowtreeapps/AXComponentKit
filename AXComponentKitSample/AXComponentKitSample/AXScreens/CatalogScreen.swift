import AXComponentKit
import AXComponentKitMacroSupport

@AXScreen
struct CatalogScreen {
    let featuredCarousel: AXScrollView = "catalog-featured-carousel"
    let categoryList: AXScrollView = "catalog-category-list"
    let categoryCard: AXDynamicComponent<Category> = "catalog-category-card"
    let featuredItem: AXDynamicComponent<Int> = "catalog-featured-item"
}
