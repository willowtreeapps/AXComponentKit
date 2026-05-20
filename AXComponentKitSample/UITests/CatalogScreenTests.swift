import AXComponentKitTestSupport
import XCTest

@MainActor
final class CatalogScreenTests: XCTestCase {
    override func setUp() async throws {
        XCUIApplication.automationLaunch()
        try await FirstTabScreen.navigator.navigate(toTab: \.catalog)
    }

    func testCatalogScreenExists() async throws {
        try await CatalogScreen.exists(timeout: .seconds(15))
    }

    func testFeaturedCarouselExists() async throws {
        try await CatalogScreen.element(\.featuredCarousel)
    }

    func testCategoryListExists() async throws {
        try await CatalogScreen.element(\.categoryList)
    }

    func testAllCategoryCardsExist() async throws {
        for category in Category.allCases {
            try await CatalogScreen.element(\.categoryCard, value: category)
        }
    }

    func testFeaturedItemsExist() async throws {
        let firstItem = CatalogScreen.assumedElement(\.featuredItem, value: 1)
        XCTAssertTrue(firstItem.waitForExistence(timeout: 5))
    }

    func testCanNavigateToElectronicsCategory() async throws {
        try await CatalogScreen.navigator.navigate(toCategory: .electronics)
        try await CategoryDetailScreen.exists()
    }

    func testCanNavigateToBooksCategory() async throws {
        try await CatalogScreen.navigator.navigate(toCategory: .books)
        try await CategoryDetailScreen.exists()
    }

    func testCategoryDetailItemsExist() async throws {
        try await CatalogScreen.navigator.navigate(toCategory: .clothing)
        let firstItem = try await CategoryDetailScreen.element(\.item, value: 1)
        XCTAssertTrue(firstItem.exists)
    }
}
