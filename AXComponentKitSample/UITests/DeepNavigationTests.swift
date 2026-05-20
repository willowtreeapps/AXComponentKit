import AXComponentKitTestSupport
import XCTest

@MainActor
final class DeepNavigationTests: XCTestCase {
    override func setUp() async throws {
        XCUIApplication.automationLaunch()
        try await FirstTabScreen.navigator.navigate(toTab: \.catalog)
    }

    func testDeepNavigationChain() async throws {
        // Level 1: Catalog tab
        try await CatalogScreen.exists(timeout: .seconds(15))

        // Level 2: Category detail
        let categoryNav = try await CatalogScreen.navigator.navigate(toCategory: .electronics)
        try await CategoryDetailScreen.exists()

        // Level 3: Item detail
        let itemNav = try await categoryNav.navigate(toItem: 1)
        try await ItemDetailScreen.exists()

        // Level 4: Share sheet (modal)
        try await itemNav.navigateToShare()
        try await ShareScreen.exists()
    }

    func testDeepNavigationToScrolledItem() async throws {
        let categoryNav = try await CatalogScreen.navigator.navigate(toCategory: .books)

        // Navigate to a deeply scrolled item
        let itemNav = try await categoryNav.navigate(toItem: 30)
        try await ItemDetailScreen.exists()

        // Verify item detail elements
        try await ItemDetailScreen.element(\.titleLabel)
        try await ItemDetailScreen.element(\.descriptionLabel)
        try await ItemDetailScreen.element(\.shareButton)

        // Open and dismiss the share sheet
        let shareNav = try await itemNav.navigateToShare()
        try await ShareScreen.exists()

        try await ShareScreen.element(\.messageField)
        try await ShareScreen.element(\.sendButton)
        try await ShareScreen.element(\.dismissButton)

        try await shareNav.dismiss()
        try await ItemDetailScreen.exists()
    }

    func testModalDismissalReturnsToItemDetail() async throws {
        try await CatalogScreen.navigator.navigate(toCategory: .clothing)
        try await CategoryDetailScreen.navigator.navigate(toItem: 5)

        let shareNav = try await ItemDetailScreen.navigator.navigateToShare()
        try await ShareScreen.exists(timeout: .seconds(15), "Share sheet should appear")

        try await shareNav.dismiss()
        try await ItemDetailScreen.exists()
    }

    func testAllTabsAccessible() async throws {
        try await CatalogScreen.navigator.navigate(toTab: \.first)
        try await FirstTabScreen.exists()

        try await FirstTabScreen.navigator.navigate(toTab: \.second)
        try await SecondTabScreen.exists()

        try await SecondTabScreen.navigator.navigate(toTab: \.settings)
        try await SettingsScreen.exists()

        try await SettingsScreen.navigator.navigate(toTab: \.catalog)
        try await CatalogScreen.exists()
    }
}
