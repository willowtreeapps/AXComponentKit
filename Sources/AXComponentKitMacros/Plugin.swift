import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct AXComponentKitMacrosPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        AXScreenMacro.self,
    ]
}
