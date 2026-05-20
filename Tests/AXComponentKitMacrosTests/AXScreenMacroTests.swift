import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import Testing

@testable import AXComponentKitMacros

private let testMacros: [String: Macro.Type] = [
    "AXScreen": AXScreenMacro.self,
]

// MARK: - pascalCaseToKebabCase

@Suite("PascalCase to kebab-case conversion")
struct PascalCaseToKebabCaseTests {
    @Test("Simple PascalCase")
    func simplePascalCase() {
        #expect(AXScreenMacro.pascalCaseToKebabCase("FirstTabScreen") == "first-tab-screen")
    }

    @Test("Leading acronym")
    func leadingAcronym() {
        #expect(AXScreenMacro.pascalCaseToKebabCase("UIKit") == "ui-kit")
    }

    @Test("Multi-letter acronym mid-word")
    func midAcronym() {
        #expect(AXScreenMacro.pascalCaseToKebabCase("URLSession") == "url-session")
    }

    @Test("Two-letter prefix")
    func twoLetterPrefix() {
        #expect(AXScreenMacro.pascalCaseToKebabCase("AXScreen") == "ax-screen")
    }

    @Test("Single word")
    func singleWord() {
        #expect(AXScreenMacro.pascalCaseToKebabCase("Login") == "login")
    }

    @Test("All uppercase")
    func allUppercase() {
        #expect(AXScreenMacro.pascalCaseToKebabCase("HTTP") == "http")
    }

    @Test("Already lowercase")
    func alreadyLowercase() {
        #expect(AXScreenMacro.pascalCaseToKebabCase("settings") == "settings")
    }
}

// MARK: - Macro expansion

@Suite("@AXScreen macro expansion")
struct AXScreenMacroExpansionTests {
    @Test("Generates screenIdentifier and AXScreen conformance")
    func basicExpansion() {
        assertMacroExpansion(
            """
            @AXScreen
            struct LoginScreen {
                let usernameField: AXComponent = "login-username"
            }
            """,
            expandedSource: """
            struct LoginScreen {
                let usernameField: AXComponent = "login-username"

                static let screenIdentifier = "login-screen"
            }

            extension LoginScreen: AXScreen {
            }
            """,
            macros: testMacros
        )
    }

    @Test("Uses custom identifier when provided")
    func customIdentifier() {
        assertMacroExpansion(
            """
            @AXScreen(identifier: "my-custom-id")
            struct LoginScreen {
            }
            """,
            expandedSource: """
            struct LoginScreen {

                static let screenIdentifier = "my-custom-id"
            }

            extension LoginScreen: AXScreen {
            }
            """,
            macros: testMacros
        )
    }

    @Test("Falls back to derived name for interpolated identifier")
    func interpolatedIdentifierFallback() {
        assertMacroExpansion(
            #"""
            @AXScreen(identifier: "foo\(bar)")
            struct LoginScreen {
            }
            """#,
            expandedSource: #"""
            struct LoginScreen {

                static let screenIdentifier = "login-screen"
            }

            extension LoginScreen: AXScreen {
            }
            """#,
            macros: testMacros
        )
    }

    @Test("Skips screenIdentifier when already declared")
    func existingScreenIdentifier() {
        assertMacroExpansion(
            """
            @AXScreen
            struct LoginScreen {
                static let screenIdentifier = "manual-id"
            }
            """,
            expandedSource: """
            struct LoginScreen {
                static let screenIdentifier = "manual-id"
            }

            extension LoginScreen: AXScreen {
            }
            """,
            macros: testMacros
        )
    }

    @Test("Skips conformance when type already conforms")
    func existingConformance() {
        assertMacroExpansion(
            """
            @AXScreen
            struct LoginScreen: AXScreen {
            }
            """,
            expandedSource: """
            struct LoginScreen: AXScreen {

                static let screenIdentifier = "login-screen"
            }
            """,
            macros: testMacros
        )
    }

    @Test("Errors when applied to a class")
    func errorOnClass() {
        assertMacroExpansion(
            """
            @AXScreen
            class LoginScreen {
            }
            """,
            expandedSource: """
            class LoginScreen {
            }
            """,
            diagnostics: [
                DiagnosticSpec(message: "@AXScreen can only be applied to a struct", line: 1, column: 1),
            ],
            macros: testMacros
        )
    }
}
