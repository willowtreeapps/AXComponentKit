import SwiftSyntax
import SwiftSyntaxMacros

public struct AXScreenMacro: MemberMacro, ExtensionMacro {

    // MARK: - MemberMacro

    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        guard let structDecl = declaration.as(StructDeclSyntax.self) else {
            throw AXScreenMacroError.notAStruct
        }

        let typeName = structDecl.name.trimmedDescription
        let identifier = extractIdentifier(from: node) ?? pascalCaseToKebabCase(typeName)

        return [
            "static let screenIdentifier = \(literal: identifier)"
        ]
    }

    // MARK: - ExtensionMacro

    public static func expansion(
        of node: AttributeSyntax,
        attachedTo declaration: some DeclGroupSyntax,
        providingExtensionsOf type: some TypeSyntaxProtocol,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [ExtensionDeclSyntax] {
        guard declaration.as(StructDeclSyntax.self) != nil else {
            throw AXScreenMacroError.notAStruct
        }

        let extensionDecl: DeclSyntax = "extension \(type.trimmed): AXScreen {}"
        guard let ext = extensionDecl.as(ExtensionDeclSyntax.self) else {
            return []
        }
        return [ext]
    }

    // MARK: - Helpers

    /// Extracts a custom identifier string from `@AXScreen(identifier: "custom-id")`, if present.
    private static func extractIdentifier(from node: AttributeSyntax) -> String? {
        guard let arguments = node.arguments?.as(LabeledExprListSyntax.self) else {
            return nil
        }
        for argument in arguments {
            if argument.label?.trimmedDescription == "identifier",
               let stringLiteral = argument.expression.as(StringLiteralExprSyntax.self),
               stringLiteral.segments.count == 1,
               let segment = stringLiteral.segments.first?.as(StringSegmentSyntax.self) {
                return segment.content.text
            }
        }
        return nil
    }

    /// Converts a PascalCase name to kebab-case.
    ///
    /// Algorithm:
    /// - Insert a hyphen before each uppercase letter that follows a lowercase letter.
    /// - Insert a hyphen before an uppercase letter that is followed by a lowercase letter
    ///   (handles acronyms like "UIKit" -> "ui-kit").
    /// - Lowercase everything.
    static func pascalCaseToKebabCase(_ name: String) -> String {
        let characters = Array(name)
        var result = ""

        for (index, char) in characters.enumerated() {
            if char.isUppercase {
                let previousIsLower = index > 0 && characters[index - 1].isLowercase
                let nextIsLower = index + 1 < characters.count && characters[index + 1].isLowercase

                if previousIsLower {
                    // e.g., "tS" in "FirstScreen" -> "t-s"
                    result.append("-")
                } else if nextIsLower && index > 0 {
                    // e.g., "IK" followed by "it" in "UIKit" -> "...-ki"
                    result.append("-")
                }
            }
            result.append(char.lowercased())
        }

        return result
    }
}

enum AXScreenMacroError: Error, CustomStringConvertible {
    case notAStruct

    var description: String {
        switch self {
        case .notAStruct:
            return "@AXScreen can only be applied to a struct"
        }
    }
}
